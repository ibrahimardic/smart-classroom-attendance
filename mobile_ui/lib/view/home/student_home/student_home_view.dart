import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/constants/app_colors.dart';
import 'package:graduation_project/core/constants/app_font_weights.dart';
import 'package:graduation_project/view_model/student_view_model.dart';
import 'package:graduation_project/widgets/text_style_generator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StudentHomeView extends StatelessWidget {
  const StudentHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 60.h, bottom: 15.h),
        child: Consumer<StudentViewModel>(
          builder: (context, viewModel, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyleGenerator(
                text: "Attandance Record",
                fontSize: 20.sp,
                fontWeight: AppFontWeights.medium,
                letterSpacing: -.01.sp,
              ),
              10.h.verticalSpace,
              const Divider(),
              Expanded(
                child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () => viewModel.changeIsDetailed(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            color: AppColors.generalOrange,
                            width: 1.sw,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextStyleGenerator(
                                      text:
                                          viewModel.attandances[index - 1].name,
                                      color: AppColors.generalWhite,
                                      fontSize: 16.sp,
                                      fontWeight: AppFontWeights.medium,
                                      letterSpacing: -.01.sp,
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                    )
                                  ],
                                ),
                                // viewModel.isDetailed
                                //     ? Expanded(
                                //         child: ListView.separated(
                                //           itemBuilder: (context, subIndex) =>
                                //               Container(
                                //                   child: TextStyleGenerator(
                                //             text: viewModel
                                //                 .attandances[index - 1]
                                //                 .attandances![subIndex]
                                //                 .day,
                                //           )),
                                //           separatorBuilder: (context, index) =>
                                //               5.h.verticalSpace,
                                //           itemCount: viewModel
                                //               .attandances[index - 1]
                                //               .attandances!
                                //               .length,
                                //         ),
                                //       )
                                //     : Container(),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    separatorBuilder: (context, index) => 15.h.verticalSpace,
                    itemCount: viewModel.attandances.length + 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
