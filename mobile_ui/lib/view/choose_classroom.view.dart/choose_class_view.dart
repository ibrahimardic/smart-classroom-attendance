import 'package:flutter/material.dart';
import 'package:graduation_project/core/constants/app_colors.dart';
import 'package:graduation_project/core/constants/app_font_weights.dart';
import 'package:graduation_project/core/constants/app_strings.dart';
import 'package:graduation_project/core/di/locator.dart';
import 'package:graduation_project/core/router/arguments/choose_class_arguments.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/router/route_manager.dart';
import 'package:graduation_project/core/router/routes.dart';
import 'package:graduation_project/view_model/choose_class_view_model.dart';
import 'package:graduation_project/view_model/home_view_model.dart';
import 'package:graduation_project/widgets/text_style_generator.dart';
import 'package:provider/provider.dart';

class ChooseClassView extends StatelessWidget {
  final ChooseClassArguments arguments;
  const ChooseClassView({
    super.key,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 60.h, bottom: 15.h),
        child: Consumer<ChooseClassViewModel>(
          builder: (context, viewModel, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      router.pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 25.sp,
                    ),
                  ),
                  12.w.horizontalSpace,
                  TextStyleGenerator(
                    text: AppStrings.lectures,
                    fontWeight: AppFontWeights.medium,
                    fontSize: 20.sp,
                  ),
                ],
              ),
              10.h.verticalSpace,
              const Divider(
                height: 0,
              ),
              Expanded(
                child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: viewModel.lecturesList.length + 1,
                    separatorBuilder: (context, index) => 15.h.verticalSpace,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () {
                            getIt<HomeViewModel>().setActiveClass(
                                viewModel.lecturesList[index - 1].name);
                            router.goNamed(Routes.homeView);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            alignment: Alignment.centerLeft,
                            width: 1.sw,
                            height: 38.h,
                            decoration: BoxDecoration(
                              color: AppColors.generalOrange,
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                            child: TextStyleGenerator(
                              text: viewModel.lecturesList[index - 1].name,
                              color: AppColors.generalWhite,
                              fontSize: 14.sp,
                              fontWeight: AppFontWeights.medium,
                              maxLine: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
