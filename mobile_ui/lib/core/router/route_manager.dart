// ignore: depend_on_referenced_packages

import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/di/locator.dart';
import 'package:graduation_project/core/router/arguments/choose_class_arguments.dart';
import 'package:graduation_project/core/router/routes.dart';
import 'package:graduation_project/view/auth/login_view.dart';
import 'package:graduation_project/view/choose_classroom.view.dart/choose_class_view.dart';
import 'package:graduation_project/view/home/lecturer_home/lecturer_has_class_view.dart';
import 'package:graduation_project/view/home/lecturer_home/lecturer_has_not_class_view.dart';
import 'package:graduation_project/view/home/student_home/student_home_view.dart';
import 'package:graduation_project/view/splash/splash_view.dart';
import 'package:graduation_project/view_model/auth/auth_view_model.dart';
import 'package:graduation_project/view_model/choose_class_view_model.dart';
import 'package:graduation_project/view_model/home_view_model.dart';
import 'package:graduation_project/view_model/splash/splas_view_model.dart';
import 'package:graduation_project/view_model/student_view_model.dart';

import 'package:provider/provider.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      name: "/",
      builder: (context, state) => MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (context) => SplashViewModel(),
        ),
        ChangeNotifierProvider.value(
          value: getIt<HomeViewModel>(),
        ),
      ], child: const SplashView()),
    ),
    GoRoute(
      path: Routes.loginView,
      name: "/login_view",
      builder: (context, state) => ChangeNotifierProvider(
          create: (context) => AuthViewModel(), child: const LoginView()),
    ),
    GoRoute(
      path: Routes.lecturerHasClassView,
      name: "/lecturer_has_class_view",
      builder: (context, state) {
        return ChangeNotifierProvider.value(
          value: getIt<HomeViewModel>(),
          child: const LecturerHasClassView(),
        );
      },
    ),
    GoRoute(
      path: Routes.lecturerHasNotClassView,
      name: "/lecturer_has_not_class_view",
      builder: (context, state) {
        return ChangeNotifierProvider.value(
          value: getIt<HomeViewModel>(),
          child: const LecturerHasNotClassView(),
        );
      },
    ),
    GoRoute(
      path: Routes.studentHomeView,
      name: "/student_home_view",
      builder: (context, state) {
        return ChangeNotifierProvider(
            create: (context) => StudentViewModel(),
            child: const StudentHomeView());
      },
    ),
    GoRoute(
      path: Routes.chooseClassView,
      name: "/choose_class_view",
      builder: (context, state) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => ChooseClassViewModel(),
            ),
            ChangeNotifierProvider.value(
              value: getIt<HomeViewModel>(),
            ),
          ],
          child: ChooseClassView(
            arguments: state.extra as ChooseClassArguments,
          ),
        );
      },
    ),
  ],
);
