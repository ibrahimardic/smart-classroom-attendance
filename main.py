import os
import pickle

import cv2

cap = cv2.VideoCapture(0)
cap.set(3,640) #Width
cap.set(4,480) #Height

imgBackground = cv2.imread('Resources/background_m.jpg')
imgBackground = cv2.resize(imgBackground,(1280,720))



folderModePath = 'Resources/Modes'
modePathList = os.listdir(folderModePath)
imgModeList = []
for path in modePathList:
    imgModeList.append(cv2.imread(os.path.join(folderModePath,path)))

# Load the Encoding file.
file = open('EncodeFile.p', 'rb')
encodeListKnownwithIds = pickle.load(file)


while True:
    success, img =cap.read()
    imgBackground[190:190 + 480, 40:40 + 640] = img
    imgBackground[0:0+720,640:640+640] = imgModeList[3]

    cv2.imshow("Face Attendance", imgBackground)
    cv2.waitKey(1)

