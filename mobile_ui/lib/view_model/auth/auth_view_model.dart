import 'package:flutter/foundation.dart';
import 'package:graduation_project/service/auth/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String _email = "";
  String _password = "";

  changeEmailValue(String input) {
    _email = input;
  }

  changePasswordValue(String input) {
    _password = input;
  }

  signIn() async {
    try {
      await _authService.signIn(_email, _password);
    } catch (e) {
      print(e);
    }
  }
}
