import 'package:flutter/material.dart';
import 'package:graduation_project/core/router/route_manager.dart';
import 'package:graduation_project/core/router/routes.dart';
import 'package:graduation_project/core/shared_prefences/shared_service.dart';
import 'package:graduation_project/core/shared_prefences/shared_strings.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel() {
    print("SplashViewModel");

    checkOnboardingNeedsToShow();
  }
  checkOnboardingNeedsToShow() async {
    await Future.delayed(const Duration(seconds: 1));

    String? userId = PreferenceUtils.getString(SharedStrings.userId);
    int? role = PreferenceUtils.getInt(SharedStrings.role);

    print("SplashViewModel / token $userId");
    print("SplashViewModel / role $role");

    if (userId != null) {
      if (role == 0) {
        router.goNamed(Routes.homeView);
      } else {
        router.goNamed(Routes.studentHomeView);
      }
    } else {
      router.goNamed(Routes.loginView);
    }
  }
}
