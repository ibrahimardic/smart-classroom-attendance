import firebase_admin
from firebase_admin import credentials, db, firestore



cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred, {
    'databaseURL':'https://graduation-project-cbc74-default-rtdb.europe-west1.firebasedatabase.app/'
})
firestoredb = firestore.client()

# Define the query
courseCode = None
query = firestoredb.collection('classrooms')

# classes = query.where('isActive', '==', True).stream()

# Print the class details
def activeClasses(class_name, courseCode = None):
    class_ref = query.document(class_name)
    class_dict = class_ref.get().to_dict()
    courseCode = class_dict.get('courseName')
    print(courseCode)
    if class_dict and class_dict.get('isActive'):
        return True
    else:
        return False

def attendedStudents(course_id, student_num):

    course_ref = firestoredb.collection('courses').document(course_id)
    course_dict = course_ref.get().to_dict()

    if course_dict:
        enrolled_students = course_dict.get('enrolledStudents', [])
        if student_num in [student['number'] for student in enrolled_students]:
            return True
    return False

print(attendedStudents('blg-403.1', '180254050'))
activeClasses('muh-205')
# print(activeClasses('muh-302'))
# print(activeClasses('muh-205'))



