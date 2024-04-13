import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred, {
    'databaseURL':'https://graduation-project-cbc74-default-rtdb.europe-west1.firebasedatabase.app/'
})

ref = db.reference('Students')

data = {
    "180254000":
        {
            "name":"Elon Musk",
            "major":"CEO",
            "starting Year":2015,
            "total attendance":6,
            "last_attendance_time": "2024-04-13 15:33:25"

        },
    "180254050":
        {
            "name":"Ibrahim Ardic",
            "major":"Computer Engineering",
            "starting Year":2018,
            "total attendance":8,
            "last_attendance_time": "2024-04-13 15:36:18"

        }
}

for key,value in data.items():
    ref.child(key).set(value)