import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/constants/app_colors.dart';
import 'package:graduation_project/core/constants/app_font_weights.dart';
import 'package:graduation_project/core/constants/app_strings.dart';
import 'package:graduation_project/core/router/route_manager.dart';
import 'package:graduation_project/core/shared_prefences/shared_service.dart';
import 'package:graduation_project/core/shared_prefences/shared_strings.dart';
import 'package:graduation_project/view_model/auth/auth_view_model.dart';
import 'package:graduation_project/widgets/primary_button.dart';
import 'package:graduation_project/widgets/text_field_widget.dart';
import 'package:graduation_project/widgets/text_style_generator.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print(PreferenceUtils.getString(SharedStrings.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          passwordFocusNode.unfocus();
          emailFocusNode.unfocus();
        },
        child: Consumer<AuthViewModel>(
          builder: (context, viewModel, _) => SingleChildScrollView(
            child: Container(
              height: 1.sh,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      64.h.verticalSpace,
                      TextStyleGenerator(
                        text: AppStrings.signIn,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      24.h.verticalSpace,
                      TextFieldWidget(
                        focusNode: emailFocusNode,
                        title: AppStrings.emailAddress,
                        placeholderText: AppStrings.emailHintText,
                        hintFontSize: 12.sp,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: (val) {
                          viewModel.changeEmailValue(val);
                        },
                        textEditingController: emailController,
                      ),
                      24.h.verticalSpace,
                      TextFieldWidget(
                        focusNode: passwordFocusNode,
                        title: AppStrings.password,
                        placeholderText: AppStrings.password,
                        hintFontSize: 12.sp,
                        textInputAction: TextInputAction.done,
                        onChanged: (val) {
                          viewModel.changePasswordValue(val);
                        },
                        onEditingComplete: () {
                          passwordFocusNode.unfocus();
                        },
                        textEditingController: passwordController,
                      ),
                      24.h.verticalSpace,
                      PrimaryButton(
                        onTap: () async {
                          await viewModel.signIn();
                          router.goNamed("/");
                          // if (emailController.text.trim() == "1") {
                          //   router.goNamed(Routes.homeView);
                          // } else if (emailController.text.trim() == "2") {
                          //   router.goNamed(Routes.studentHomeView);
                          // }
                        },
                        text: AppStrings.signIn,
                        backgroundColor: AppColors.generalOrange,
                        borderColor: AppColors.generalOrange,
                        textColor: AppColors.generalWhite,
                      ),
                      12.h.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: TextStyleGenerator(
                              text: AppStrings.forgetPassword,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  "By proceeding, you acknowledge that you have accepted our ",
                              style: TextStyle(
                                color: AppColors.generalBlack,
                                fontSize: 12.sp,
                                fontWeight: AppFontWeights.regular,
                                letterSpacing: .4.sp,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms of Use',
                              style: TextStyle(
                                color: AppColors.generalOrange,
                                fontSize: 12.sp,
                                fontWeight: AppFontWeights.semiBold,
                                letterSpacing: .4.sp,
                              ),
                            ),
                            TextSpan(
                              text: ' and ',
                              style: TextStyle(
                                color: AppColors.generalBlack,
                                fontSize: 12.sp,
                                fontWeight: AppFontWeights.regular,
                                letterSpacing: .01.sp,
                              ),
                            ),
                            TextSpan(
                              text: AppStrings.privacyPolicy,
                              style: TextStyle(
                                color: AppColors.generalOrange,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: .4.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  34.h.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
