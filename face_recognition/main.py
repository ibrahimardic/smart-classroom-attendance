import datetime
import os
import pickle
from win32com.client import Dispatch
import fsdatabase
import cv2
import cvzone
import face_recognition
import firebase_admin
import numpy as np
from firebase_admin import credentials, db, firestore
import threading
#import multiprocessing

#System of muh-205.
result = fsdatabase.activeClasses('muh-205')
courseName = fsdatabase.courseName()

def speak(str1):
    def speak_thread():
        speak = Dispatch(("SAPI.SpVoice"))
        speak.Speak(str1)

    thread = threading.Thread(target=speak_thread)
    thread.start()

def process_frame(img):
    imgSmall = cv2.resize(img, ( 0, 0 ), None, 0.25, 0.25)
    imgSmall = cv2.cvtColor(imgSmall, cv2.COLOR_BGR2RGB)
    faceCurFrame = face_recognition.face_locations(imgSmall)
    encodeCurFrame = face_recognition.face_encodings(imgSmall, faceCurFrame)
    return faceCurFrame, encodeCurFrame

folderModePath = 'Resources/Modes'
modePathList = os.listdir(folderModePath)
imgModeList = [cv2.imread(os.path.join(folderModePath, path)) for path in modePathList]


# Load the Encoding file.
print('Loading Encoded File Started...')
with open('EncodeFile.p','rb') as file:
    encodeListKnownwithIds = pickle.load(file)
print('Loading Encoded File Completed')

encodeListKnown, studentIds = encodeListKnownwithIds

#print(studentIds)

modeType =0 # It shows us it's active
counter =0
id = -1
speak_called = False

cap = None
frame_interval = 3 # Process to reduce load
frame_count = 0

student_info_cache = {}
attendance_status_cache = {}


#Getting student info from cache, not from database to improve system's efficiency.
def get_student_info(student_id):
    if student_id in student_info_cache:
        return student_info_cache[student_id]
    student_info = db.reference(f'Students/{student_id}').get()
    student_info_cache[student_id] = student_info
    return student_info

#Checking attendance status from cache, not from database to improve efficiency.
def check_attendance_status(course,student_number):
    cache_key = f"{course}_{student_number}"
    if cache_key in attendance_status_cache:
        return attendance_status_cache[cache_key]
    status = fsdatabase.attendedStudents(course, student_number)
    attendance_status_cache[cache_key] = status
    return status

while True:
    result = fsdatabase.activeClasses('muh-205')
    print(counter)

    if result:
        if cap == None:
            cap = cv2.VideoCapture(0, cv2.CAP_DSHOW)
            cap.set(3, 640)  # Width
            cap.set(4, 480)  # Height

        imgBackground = cv2.imread('Resources/background_m.jpg')
        imgBackground = cv2.resize(imgBackground, (1280, 720))

        success, img =cap.read()

        if frame_count % frame_interval == 0:
            faceCurFrame, encodeCurFrame = process_frame(img)

        imgBackground[190:190 + 480, 40:40 + 640] = img
        imgBackground[0:0+720,640:640+640] = imgModeList[modeType]

        if faceCurFrame:
            # We are zipping these together to use them in one loop
            for encodeFace, faceLoc in zip(encodeCurFrame, faceCurFrame):
                #Matches return boolean val.
                matches = face_recognition.compare_faces(encodeListKnown, encodeFace)
                #It returns float value, comparing with all faces. Lower value, closer match.
                faceDistance = face_recognition.face_distance(encodeListKnown, encodeFace)
                #print("matches", matches)
                #print("distance", faceDistance)

                #Taking the closest face distance.
                matchIndex = np.argmin(faceDistance)
                #print("Match Index: ", matchIndex)

                if matches[matchIndex]:
                    y1, x2, y2, x1 = faceLoc
                    #We need to multiply the locations by 4 because we scaled it 0.25.
                    y1, x2, y2, x1 = y1*4, x2*4, y2*4, x1*4
                    #Showing the cam's location on background photo.
                    bbox = 40+ x1, 190+ y1, x2-x1, y2-y1
                    imgBackground = cvzone.cornerRect(imgBackground, bbox, rt=0)
                    id = studentIds[matchIndex]
                    studentInfo = db.reference(f'Students/{id}').get()

                    if counter==0:
                        cv2.imshow("Face Attendance", imgBackground)
                        cv2.waitKey(1)
                        counter = 1
                        modeType = 1

            if counter != 0 :
                student_number = str(studentInfo['Student Number'])
                if not check_attendance_status(courseName, student_number):
                    if not speak_called:
                        speak('You are not enrolled in this course.')
                        speak_called = True
                    modeType = 0  # Reset modeType to default
                    counter = 0  # Reset counter
                    continue

                #Getting data from the cache for system efficiency
                if counter ==1 :
                    #print(studentInfo)
                    #Check if already marked
                    datetimeobject = datetime.datetime.strptime(studentInfo['last_attendance_time'],
                                                      "%Y-%m-%d %H:%M:%S")
                    secondsElapsed = (datetime.datetime.now()-datetimeobject).total_seconds()
                    #print(secondsElapsed)
                    if secondsElapsed>900 and not fsdatabase.isStudentAttended(str(studentInfo['Student Number'])):
                        #Updating data of attendance
                        ref = db.reference(f'Students/{id}')
                        studentInfo['total attendance'] += 1
                        ref.child('total attendance').set(studentInfo['total attendance'])
                        ref.child('last_attendance_time').set(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
                        fsdatabase.updateStudentAttendance(str(studentInfo['Student Number']))


                    #If already marked
                    else:
                        modeType = 3
                        counter=0
                        imgBackground[0:0 + 720, 640:640 + 640] = imgModeList[modeType]
                        if not speak_called:
                            speak("Your attendance is already taken.")
                            speak_called = True

                if check_attendance_status(courseName,student_number):

                    name = str(studentInfo['name'])
                    short_name = (name[:15] + '.') if len(name) > 15 else name
                    major = str(studentInfo['major'])
                    short_major = (major[:21] +'.') if len(major)> 21 else major

                    if modeType !=3:
                        #Marked mode.
                        if 13<counter<=18:
                            modeType=2

                        imgBackground[0:0 + 720, 640:640 + 640] = imgModeList[modeType]
                        if counter == 1 and not speak_called:
                            speak(f"Attendance is taken for {studentInfo['name']}")
                            speak_called = True

                        #Student informations
                        if counter <=12:
                            #Writing this data to application background manually. Not so accurate, need to upgraded.
                            cv2.putText(imgBackground ,short_name, (868,236),
                                        cv2.FONT_HERSHEY_COMPLEX,1,(0,0,0),1)
                            cv2.putText(imgBackground, short_major, (868, 322),
                                        cv2.FONT_HERSHEY_COMPLEX, 0.65, (0, 0, 0),1)
                            cv2.putText(imgBackground, str(studentInfo['Student Number']), (950, 420),
                                        cv2.FONT_HERSHEY_COMPLEX, 0.65, (0, 0, 0), 1)
                            cv2.putText(imgBackground, str(studentInfo['last_attendance_time']), (907, 507),
                                        cv2.FONT_HERSHEY_COMPLEX, 0.65, (0, 0, 0), 1)
                            cv2.putText(imgBackground, str(studentInfo['total attendance']), (917, 595),
                                        cv2.FONT_HERSHEY_COMPLEX, 0.65, (0, 0, 0), 1)

                        counter +=1

                        #Resetting.
                        if counter >18:
                            counter=0
                            modeType=0
                            studentInfo=[]
                            imgBackground[0:0 + 720, 640:640 + 640] = imgModeList[modeType]
                            speak_called = False

        else:
            modeType=0
            counter=0
            speak_called = False

        cv2.imshow("Face Attendance", imgBackground)
        cv2.waitKey(1)

    else:
        cv2.destroyAllWindows()
        if cap != None:
            cap.release()
            cap = None
