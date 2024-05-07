import 'package:cloud_firestore/cloud_firestore.dart';

class LecturerService {
  final classroomsCollection =
      FirebaseFirestore.instance.collection("classrooms");

  postIsActive() async {
    print("postIsActive");
    try {
      await classroomsCollection
          .doc("muh-302")
          .update({"isActive": true, "whoUsing": ""});
    } catch (e) {
      print(e.toString());
    }
  }
}
