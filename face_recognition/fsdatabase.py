import firebase_admin
from firebase_admin import credentials, db, firestore

cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred, {
    'databaseURL':'https://graduation-project-cbc74-default-rtdb.europe-west1.firebasedatabase.app/'
})
firestoredb = firestore.client()

# Define the query
query = firestoredb.collection('classrooms')
# classes = query.where('isActive', '==', True).stream()

# Print the class details
def activeClasses(class_name):
    class_ref = query.document(class_name)
    class_dict = class_ref.get().to_dict()
    if class_dict and class_dict.get('isActive'):
        return True
    else:
        return False

# print(activeClasses('muh-302'))
# print(activeClasses('muh-205'))



