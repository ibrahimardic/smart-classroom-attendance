import os
import pickle
import numpy as np
import cvzone
import cv2
import face_recognition
import firebase_admin
from firebase_admin import credentials, db
import datetime

cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred, {
    'databaseURL':'https://graduation-project-cbc74-default-rtdb.europe-west1.firebasedatabase.app/'
})

cap = cv2.VideoCapture(0)
cap.set(3,640) #Width
cap.set(4,480) #Height

imgBackground = cv2.imread('Resources/background_m.jpg')
imgBackground = cv2.resize(imgBackground  ,(1280,720))


folderModePath = 'Resources/Modes'
modePathList = os.listdir(folderModePath)
imgModeList = []
for path in modePathList:
    imgModeList.append(cv2.imread(os.path.join(folderModePath,path)))

# Load the Encoding file.
print('Loading Encoded File Started...')
file = open('EncodeFile.p', 'rb')
print('Loading Encoded File Completed')

encodeListKnownwithIds = pickle.load(file)
file.close()
encodeListKnown, studentIds = encodeListKnownwithIds

#print(studentIds)

modeType =0 # It shows us it's active
counter =0
id = -1

while True:
    success, img =cap.read()

    #Scaling images due to computation power
    imgSmall = cv2.resize(img, (0,0), None,0.25,0.25 )
    imgSmall = cv2.cvtColor(imgSmall, cv2.COLOR_BGR2RGB)


    faceCurFrame = face_recognition.face_locations(imgSmall)
    encodeCurFrame = face_recognition.face_encodings(imgSmall,faceCurFrame)


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
                if counter==0:
                    cvzone.putTextRect(imgBackground, "Loading",(275,400))
                    cv2.imshow("Face Attendance", imgBackground)
                    cv2.waitKey(1)
                    counter = 1
                    modeType = 1
        if counter != 0:

            #We'll download all the data from realtime database.
            if counter ==1:
                studentInfo = db.reference(f'Students/{id}').get()
                #print(studentInfo)

                #Check if already marked
                datetimeobject = datetime.datetime.strptime(studentInfo['last_attendance_time'],
                                                  "%Y-%m-%d %H:%M:%S")
                secondsElapsed = (datetime.datetime.now()-datetimeobject).total_seconds()
                #print(secondsElapsed)
                if secondsElapsed>3600:
                    #Updating data of attendance
                    ref = db.reference(f'Students/{id}')
                    studentInfo['total attendance'] += 1
                    ref.child('total attendance').set(studentInfo['total attendance'])
                    ref.child('last_attendance_time').set(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
                #If already marked
                else:
                    modeType = 3
                    counter=0
                    imgBackground[0:0 + 720, 640:640 + 640] = imgModeList[modeType]

            if modeType !=3:


                #Marked mode.
                if 100<counter<=180:
                    modeType=2

                imgBackground[0:0 + 720, 640:640 + 640] = imgModeList[modeType]

                #Student informations
                if counter <=100:
                    #Writing this data to application background manually. Not so accurate, need to upgraded.
                    cv2.putText(imgBackground ,str(studentInfo['name']), (868,236),
                                cv2.FONT_HERSHEY_COMPLEX,1,(0,0,0),1)
                    cv2.putText(imgBackground, str(studentInfo['major']), (868, 322),
                                cv2.FONT_HERSHEY_COMPLEX, 0.65, (0, 0, 0),1)
                    cv2.putText(imgBackground, str(studentInfo['starting Year']), (972, 418),
                                cv2.FONT_HERSHEY_COMPLEX, 0.65, (0, 0, 0), 1)
                    cv2.putText(imgBackground, str(studentInfo['last_attendance_time']), (907, 507),
                                cv2.FONT_HERSHEY_COMPLEX, 0.65, (0, 0, 0), 1)
                    cv2.putText(imgBackground, str(studentInfo['total attendance']), (917, 595),
                                cv2.FONT_HERSHEY_COMPLEX, 0.65, (0, 0, 0), 1)

                counter +=1

                #Resetting.
                if counter >180:
                    counter=0
                    modeType=0
                    studentInfo=[]
                    imgBackground[0:0 + 720, 640:640 + 640] = imgModeList[modeType]

    #If no face detected.
    else:
        modeType=0
        counter=0
    cv2.imshow("Face Attendance", imgBackground)
    cv2.waitKey(1)

