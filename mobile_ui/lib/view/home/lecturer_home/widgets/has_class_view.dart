import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/constants/app_colors.dart';
import 'package:graduation_project/core/constants/app_font_weights.dart';
import 'package:graduation_project/core/constants/app_strings.dart';
import 'package:graduation_project/core/router/route_manager.dart';
import 'package:graduation_project/view_model/home_view_model.dart';
import 'package:graduation_project/widgets/primary_button.dart';
import 'package:graduation_project/widgets/text_style_generator.dart';

class HasClassView extends StatelessWidget {
  final HomeViewModel viewModel;
  const HasClassView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyleGenerator(
                text: AppStrings.attandanceRecord,
                fontWeight: AppFontWeights.medium,
                fontSize: 20.sp,
              ),
              10.h.verticalSpace,
              const Divider(
                height: 0,
              ),
              10.h.verticalSpace,
              TextStyleGenerator(
                text: "Students",
                fontSize: 16.sp,
                fontWeight: AppFontWeights.medium,
                letterSpacing: -.01.sp,
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    if (index != 0) {
                      return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          alignment: Alignment.centerLeft,
                          height: 30.h,
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextStyleGenerator(
                                text:
                                    "${viewModel.attandedStudents[index - 1].name}",
                                fontSize: 12.sp,
                                fontWeight: AppFontWeights.regular,
                              ),
                              GestureDetector(
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 10.w),
                                      width: 1.sw,
                                      height: .16.sh,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextStyleGenerator(
                                            alignment: TextAlign.center,
                                            text:
                                                "Are you sure you want to delete attandance of that student",
                                            fontSize: 14.sp,
                                            letterSpacing: -.01.sp,
                                          ),
                                          20.h.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              PrimaryButton(
                                                onTap: () {
                                                  router.pop();
                                                },
                                                text: "No",
                                                width: .3,
                                                height: 35.h,
                                                backgroundColor:
                                                    AppColors.generalWhite,
                                                textColor:
                                                    AppColors.generalBlack,
                                              ),
                                              PrimaryButton(
                                                onTap: () {
                                                  viewModel
                                                      .deleteStudentFromAttandance(
                                                          index - 1);
                                                  router.pop();
                                                },
                                                text: "Yes",
                                                width: .3,
                                                height: 35.h,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                child: Icon(Icons.close),
                              )
                            ],
                          ));
                    } else {
                      return Container();
                    }
                  },
                  separatorBuilder: (context, index) => 15.h.verticalSpace,
                  itemCount: viewModel.attandedStudents.length + 1,
                ),
              ),
            ],
          ),
        ),
        TextStyleGenerator(
          text: "Toplam: ${viewModel.attandedStudents.length}",
          fontSize: 16.sp,
          fontWeight: AppFontWeights.medium,
        ),
        10.h.verticalSpace,
        PrimaryButton(
          text: AppStrings.deactivate,
          onTap: () => showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      width: 1.sw,
                      height: .13.sh,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextStyleGenerator(
                            text: "Are you sure you want to deactivate class",
                            fontSize: 14.sp,
                            letterSpacing: -.01.sp,
                          ),
                          20.h.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PrimaryButton(
                                onTap: () {
                                  router.pop();
                                },
                                text: "No",
                                width: .3,
                                height: 35.h,
                                backgroundColor: AppColors.generalWhite,
                                textColor: AppColors.generalBlack,
                              ),
                              PrimaryButton(
                                onTap: () {
                                  viewModel.setActiveClass(null);
                                  router.pop();
                                },
                                text: "Yes",
                                width: .3,
                                height: 35.h,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
        ),
        24.h.verticalSpace
      ],
    );
  }
}
