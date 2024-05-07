import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/view/home/lecturer_home/widgets/has_not_class_view.dart';
import 'package:graduation_project/view/home/lecturer_home/widgets/has_class_view.dart';
import 'package:graduation_project/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 60.h, bottom: 15.h),
        child: Consumer<HomeViewModel>(builder: (context, viewModel, _) {
          if (viewModel.activeClass != null) {
            return HasClassView(viewModel: viewModel);
          } else {
            return HasNotClassView(viewModel: viewModel);
          }
        }),
      ),
    );
  }
}
