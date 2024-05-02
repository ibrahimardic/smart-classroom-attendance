import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/constants/app_colors.dart';
import 'package:graduation_project/core/constants/app_font_weights.dart';
import 'package:graduation_project/widgets/text_style_generator.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double width;
  final double height;
  final Widget? icon;
  final int buttonTitleFontSize;

  final Function()? onTap;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.backgroundColor = AppColors.generalOrange,
    this.textColor = AppColors.generalWhite,
    this.borderColor = AppColors.generalOrange,
    this.icon,
    this.width = 1,
    this.height = 48,
    this.buttonTitleFontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width.sw,
        height: height.h,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(32.sp),
            ),
            border: Border.all(
              color: borderColor ?? AppColors.generalOrange,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              5.w.horizontalSpace,
            ],
            Center(
              child: TextStyleGenerator(
                text: text,
                color: textColor,
                fontSize: buttonTitleFontSize.sp,
                fontWeight: AppFontWeights.semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
