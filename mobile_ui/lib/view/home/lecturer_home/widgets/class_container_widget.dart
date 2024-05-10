import 'package:flutter/material.dart';
import 'package:graduation_project/core/constants/app_colors.dart';
import 'package:graduation_project/core/constants/app_font_weights.dart';
import 'package:graduation_project/widgets/text_style_generator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClassContainerWidget extends StatelessWidget {
  final String className;
  final String? lecturerName;
  final String? lectureName;
  final bool isActive;
  const ClassContainerWidget({
    super.key,
    required this.className,
    required this.isActive,
    this.lectureName,
    this.lecturerName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      width: 1.sw,
      decoration: BoxDecoration(
        color: AppColors.generalOrange,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lectureName != null
                  ? TextStyleGenerator(
                      text: lectureName,
                      fontWeight: AppFontWeights.medium,
                      fontSize: 10.sp,
                      color: AppColors.generalWhite,
                    )
                  : Container(),
              lecturerName != null
                  ? TextStyleGenerator(
                      text: lecturerName,
                      fontWeight: AppFontWeights.medium,
                      fontSize: 10.sp,
                      color: AppColors.generalWhite,
                    )
                  : Container(),
              TextStyleGenerator(
                text: className,
                fontWeight: AppFontWeights.medium,
                fontSize: 20.sp,
                color: AppColors.generalWhite,
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.generalLightGreen
                      : AppColors.generalDarkGreen,
                  borderRadius: BorderRadius.circular(45.sp)),
            ),
          ),
        ],
      ),
    );
  }
}
