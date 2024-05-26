import firebase_admin
from firebase_admin import credentials, db, firestore
import datetime


cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred, {
    'databaseURL':'https://graduation-project-cbc74-default-rtdb.europe-west1.firebasedatabase.app/'
})


ref = db.reference('Students')
database = firestore.client()


data = {
    "180254000":
        {
            "name":"Elon Musk",
            "major":"CEO",
            "Student Number":180254000,
            "total attendance":6,
            "last_attendance_time": "2024-04-13 15:33:25",
            "courses": ["blg-403.1", "sec-404.2"],
            "role":1

},
    "180254050":
        {
            "name":"Ibrahim Ardic",
            "major":"Computer Engineering",
            "Student Number":180254050,
            "total attendance":8,
            "last_attendance_time": "2024-04-13 15:36:18",
            "courses": ["blg-403.2", "blg-402.4"],
            "role":1

},
    "180254037":
        {
            "name": "Batuhan Yildizhan",
            "major": "Computer Engineering",
            "Student Number": 180254037,
            "total attendance": 8,
            "last_attendance_time": "2024-04-13 12:21:18",
            "courses": ["blg-403.1", "blg-402.4", "sec-404.2"],
            "role":1
        }
}

data2 = {
    "180254037":
        {
            "name": "Ibrahim Ardic",
            "studentNumber": 180254050,
            "courses": [{
                "courseName": "blg-403.1",
                "record": [{
                             "date" : datetime.datetime.now(),
                            "isAttended": False
                         }]

                         }],
            #            #["blg-403.1", "blg-402.4", "sec-404.2"],
            "role": 1
        }
}


for key,value in data.items():
    ref.child(key).set(value)

for student_id, student_data in data2.items():
    document_ref = database.collection('users').document()
    document_ref.set({
        'studentNumber': str(student_data['studentNumber']),
        'name': student_data['name'],
        'takingCourse': student_data['courses'],
        'role': student_data['role']
    })