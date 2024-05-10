import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/view_model/splash/splas_view_model.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SplashViewModel>(
        builder: (context, viewModel, _) => Center(
          child: Text(
            "Splash",
            style: TextStyle(
              fontSize: 22.sp,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
