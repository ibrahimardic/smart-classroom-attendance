import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/core/shared_prefences/shared_service.dart';
import 'package:graduation_project/core/shared_prefences/shared_strings.dart';
import 'package:graduation_project/model/classes_model.dart';
import 'package:graduation_project/model/user_model.dart';

class HomeService {
  final fireStore = FirebaseFirestore.instance;
  String? accessToken = PreferenceUtils.getString(SharedStrings.userId);

  Future<UserModel?> getUserData() async {
    print("HomeService");
    try {
      if (accessToken != null) {
        final response =
            await fireStore.collection("users").doc(accessToken).get();
        if (response.exists) {
          final responseBody = response.data();
          UserModel user = UserModel.fromJson(responseBody!);
          return user;
        } else {
          print("HomeService / getUserData / userNotExist");
        }
      } else {
        print("HomeService / getUserData / accessTokenNull");
      }
      return null;
    } catch (e) {
      print("HomeService / getUserData ${e}");
      return null;
    }
  }

  Future getClasses() async {
    print("HomeService");
    try {
      final response = await fireStore.collection("classrooms").get();
      final documents = response.docs;

      List<ClassesModel> classesModel = documents
          .map((element) => ClassesModel.fromJson(element.data(), element.id))
          .toList();

      return classesModel;
    } catch (e) {
      print("HomeService / getUserData ${e}");
    }
  }

  Future<bool> setClassroomActive(
      String docId, String lectureName, String lecturerName) async {
    print("class activated");
    try {
      await fireStore.collection("classrooms").doc(docId).update({
        "isActive": true,
        "whoUsing": lecturerName,
        "courseName": lectureName,
      });

      await fireStore.collection("users").doc(accessToken).update({
        "activeClass": docId,
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setClassroomDeactive(String docId) async {
    print("object");
    try {
      await fireStore.collection("classrooms").doc(docId).set({
        "isActive": false,
        "attandedStudents": [],
      });

      await fireStore
          .collection("users")
          .doc(accessToken)
          .update({'activeClass': null});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<String>> getAttandedStudents(String docId) async {
    try {
      final response =
          await fireStore.collection("classrooms").doc(docId).get();

      final responseBody = response.data();

      ClassesModel classModel = ClassesModel.fromJson(responseBody!, docId);

      return classModel.attandedStudents;
    } catch (e) {
      print("getAttandedStudents/ $e");

      return [];
    }
  }
}
