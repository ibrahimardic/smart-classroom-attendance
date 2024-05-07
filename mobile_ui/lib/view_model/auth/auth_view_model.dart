import 'package:flutter/foundation.dart';
import 'package:graduation_project/core/router/route_manager.dart';
import 'package:graduation_project/core/router/routes.dart';
import 'package:graduation_project/core/shared_prefences/shared_service.dart';
import 'package:graduation_project/core/shared_prefences/shared_strings.dart';
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
      // if (PreferenceUtils.getString(SharedStrings.userId) != null) {
      //   router.goNamed(Routes.homeView);
      // }
    } catch (e) {
      print(e);
    }
  }
}
