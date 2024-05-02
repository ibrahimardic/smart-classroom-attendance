import cv2
import face_recognition
import pickle
import os

folderpath = 'Images'
PathList = os.listdir(folderpath)
imgList = []
studentIds =[]

for path in PathList:
    #Appending Imgs to imgList
    imgList.append(cv2.imread(os.path.join(folderpath,path)))

    # Assume that, name of the images are Student ids.
    studentIds.append(os.path.splitext(path)[0])

print(studentIds)

def findEncodings(imagesList):
    encodeList = []
    for img in imagesList:
        #Opencv uses BGR, Face-recog uses RGB. So converting is a must.
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        encode = face_recognition.face_encodings(img)[0]
        encodeList.append(encode)

    return encodeList

print("Encoding Started...")
encodeListKnown = findEncodings(imgList)
encodeListKnownwithIds = [encodeListKnown, studentIds]
print("Encoding Complete")


file = open("EncodeFile.p", 'wb')
pickle.dump(encodeListKnownwithIds, file)
file.close()
print('File saved')
