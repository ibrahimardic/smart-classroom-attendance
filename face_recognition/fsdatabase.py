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


def isStudentAttended( student_num, classroom_id = 'muh-205'):
    doc_ref = firestoredb.collection('classrooms').document(classroom_id)
    doc = doc_ref.get()
    if doc.exists:

        classroom_dict = doc.to_dict()
        attended_students = classroom_dict.get('attandedStudents', [])

        # Check if the student's attendance is true
        for student in attended_students:
            if student.get('number') == student_num:
                return student.get('isAttanded', False)

    return False


def updateStudentAttendance(student_num, classroom_id='muh-205'):
    db = firestore.client()
    doc_ref = db.collection('classrooms').document(classroom_id)
    doc = doc_ref.get()

    if doc.exists:
        classroom_dict = doc.to_dict()
        attended_students = classroom_dict.get('attandedStudents', [])
        student_found = False

        # Check if the student is already in the list
        for student in attended_students:
            if student.get('number') == student_num:
                student['isAttanded'] = True
                student_found = True
                break

        # If the student is not found, add them to the list
        if not student_found:
            attended_students.append({'number': student_num, 'isAttanded': True})

        # Update the document with the modified attendance list
        doc_ref.update({'attandedStudents': attended_students})
        return True

    return False

# updateStudentAttendance('180254050')
# print(isStudentAttended('180254000'))
# print(attendedStudents('blg-403.1', '180254050'))
# activeClasses('muh-205')
# print(activeClasses('muh-302'))
# print(activeClasses('muh-205'))



