import os
import pickle
import numpy as np
import cvzone
import cv2
import face_recognition

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


while True:
    success, img =cap.read()

    #Scaling images due to computation power
    imgSmall = cv2.resize(img, (0,0), None,0.25,0.25 )
    imgSmall = cv2.cvtColor(imgSmall, cv2.COLOR_BGR2RGB)


    faceCurFrame = face_recognition.face_locations(imgSmall)
    encodeCurFrame = face_recognition.face_encodings(imgSmall,faceCurFrame)


    imgBackground[190:190 + 480, 40:40 + 640] = img
    imgBackground[0:0+720,640:640+640] = imgModeList[0]

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

    cv2.imshow("Face Attendance", imgBackground)
    cv2.waitKey(1)

