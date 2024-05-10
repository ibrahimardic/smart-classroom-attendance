import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/core/shared_prefences/shared_service.dart';
import 'package:graduation_project/core/shared_prefences/shared_strings.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  signIn(String email, String password) async {
    try {
      final loginResponse = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final String accessToken = loginResponse.user!.uid;
      PreferenceUtils.setString(SharedStrings.userId, accessToken);

      await getUserData(accessToken);
    } catch (e) {
      print("AuthService / signIn ${e}");
    }
  }

  getUserData(String accessToken) async {
    try {
      final response =
          await fireStore.collection("users").doc(accessToken).get();
      if (response.exists) {
        final data = response.data();
        PreferenceUtils.setInt(SharedStrings.role, data!["role"]);
      }
    } catch (e) {
      print("AuthService / getUserData ${e}");
    }
  }
}
