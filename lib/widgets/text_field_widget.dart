import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/constants/app_colors.dart';
import 'package:graduation_project/widgets/text_style_generator.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatefulWidget {
  final String? title;
  final Color borderColor; //borderColor
  final String? placeholderText; //hintText
  final String? errorText;
  final bool showRequirements;
  final TextEditingController textEditingController; //controller
  final double? hintFontSize;
  final String? counterText;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final AlignmentGeometry? alignment;
  final double? borderWidth;
  final double? borderRadius;
  final void Function(String val)? onChanged;
  final double? titleSize;
  final FontWeight? titleFontWeight;
  final TextAlign textAlign;
  final FontWeight? inputFontWeight;

  final bool isPassword;
  final String? labelText;
  final Widget? customLabel;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function? onEditingComplete;
  final int? maxLength;
  final int? maxLines;
  final double width;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final double? height;

  const TextFieldWidget({
    super.key,
    this.textAlign = TextAlign.start,
    this.titleSize,
    this.prefixIcon,
    this.contentPadding,
    this.counterText,
    this.hintFontSize,
    this.errorText,
    this.placeholderText,
    this.customLabel,
    this.labelText,
    this.onEditingComplete,
    this.textInputAction,
    this.validator,
    this.isPassword = false,
    this.keyboardType,
    this.maxLength,
    this.onChanged,
    this.borderColor = AppColors.textFieldBorderColor,
    this.focusNode,
    this.suffixIcon,
    this.inputFormatters,
    this.maxLines = 1,
    this.width = .85,
    required this.textEditingController,
    this.title,
    this.showRequirements = false,
    this.alignment = Alignment.center,
    this.borderWidth,
    this.borderRadius,
    this.titleFontWeight,
    this.height,
    this.inputFontWeight,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final fieldKey = GlobalKey<FormFieldState>();

  bool isObscure = true;
  // bool isEmpty = true;

  //@override
  // void initState() {
  //   super.initState();

  //   widget.textEditingController.addListener(() {
  //     if (!mounted) return;

  //     setState(() {
  //       isEmpty = widget.textEditingController.text.isNotEmpty ? false : true;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          TextStyleGenerator(
            text: widget.title,
            fontSize: widget.titleSize ?? 14.sp,
            fontWeight: widget.titleFontWeight ?? FontWeight.w500,
          ),
          8.h.verticalSpace,
        ],
        Container(
          width: 1.sw,
          height: widget.height,
          alignment: widget.alignment,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.borderColor,
              width: widget.borderWidth ?? 1.sp,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius ?? 32.sp),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.top,
            cursorColor: AppColors.generalBlack,
            style: TextStyle(
              color: AppColors.generalBlack,
              fontSize: 12.sp,
              fontWeight: widget.inputFontWeight,
            ),
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            textAlign: widget.textAlign,
            keyboardType: widget.keyboardType,
            controller: widget.textEditingController,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            key: fieldKey,
            focusNode: widget.focusNode,
            obscureText: widget.isPassword ? isObscure : false,
            onEditingComplete: () {
              fieldKey.currentState!.validate();
              //save string
              if (widget.onEditingComplete == null) {
                if (widget.textInputAction == TextInputAction.next) {
                  FocusScope.of(context).nextFocus();
                }
              } else {
                widget.onEditingComplete!();
              }
            },
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              contentPadding: widget.contentPadding,
              counterText: widget.counterText,
              hintStyle: TextStyle(
                color: AppColors.generalGrey,
                fontWeight: FontWeight.w500,
                fontSize: widget.hintFontSize,
              ),
              errorStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.generalWhite,
              ),
              floatingLabelStyle: const TextStyle(
                color: AppColors.generalWhite,
              ),
              label: widget.customLabel,
              labelText: widget.customLabel == null ? widget.labelText : null,
              labelStyle: const TextStyle(
                color: AppColors.generalWhite,
              ),

              hintText: widget.placeholderText,

              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        isObscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.generalWhite,
                        size: 20,
                      ),
                      highlightColor: AppColors.transparent,
                      splashColor: AppColors.transparent,
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    )
                  : null,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              //OutlineInputBorder(
              //   borderSide: BorderSide(
              //     width: .5,
              //     color: Colors.grey.shade700,
              //   ),
              //   borderRadius: const BorderRadius.all(
              //     Radius.circular(10),
              //   ),
              // ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: .5,
                  color: AppColors.generalGrey,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: InputBorder.none,
              // const OutlineInputBorder(
              //   borderSide: BorderSide(
              //     width: 1,
              //     color: AppColor.generalWhite,
              //   ),
              //   borderRadius: BorderRadius.all(
              //     Radius.circular(10),
              //   ),
              // ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 3,
                  color: AppColors.generalRed,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.sp),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: AppColors.generalRed,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.sp),
                ),
              ),
            ),
          ),
        ),
        if (widget.errorText != null && widget.errorText != "") ...[
          8.h.verticalSpace,
          Row(
            children: [
              Icon(
                Icons.error,
                size: 16.sp,
              ),
              5.w.horizontalSpace,
              SizedBox(
                width: .7.sw,
                child: TextStyleGenerator(
                  text: widget.errorText,
                  color: AppColors.generalRed,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
