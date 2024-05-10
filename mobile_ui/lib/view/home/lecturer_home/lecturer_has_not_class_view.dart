import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/constants/app_font_weights.dart';
import 'package:graduation_project/core/constants/app_strings.dart';
import 'package:graduation_project/core/di/locator.dart';
import 'package:graduation_project/core/router/arguments/choose_class_arguments.dart';
import 'package:graduation_project/core/router/route_manager.dart';
import 'package:graduation_project/core/router/routes.dart';
import 'package:graduation_project/view/home/lecturer_home/widgets/class_container_widget.dart';
import 'package:graduation_project/view_model/home_view_model.dart';
import 'package:graduation_project/widgets/text_style_generator.dart';
import 'package:provider/provider.dart';

class LecturerHasNotClassView extends StatefulWidget {
  const LecturerHasNotClassView({super.key});

  @override
  State<LecturerHasNotClassView> createState() =>
      _LecturerHasNotClassViewState();
}

class _LecturerHasNotClassViewState extends State<LecturerHasNotClassView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIt<HomeViewModel>().getAttandedStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 60.h, bottom: 15.h),
        child: Consumer<HomeViewModel>(
          builder: (context, viewModel, _) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextStyleGenerator(
                    text: AppStrings.classes,
                    fontWeight: AppFontWeights.medium,
                    fontSize: 20.sp,
                  ),
                  10.h.verticalSpace,
                  const Divider(
                    height: 0,
                  ),
                  Expanded(
                    child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: viewModel.classesList.length + 1,
                        separatorBuilder: (context, index) =>
                            15.h.verticalSpace,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Container();
                          } else if (index ==
                              viewModel.classesList.length + 1) {
                            return Container();
                          } else {
                            return GestureDetector(
                              onTap: () {
                                if (viewModel.classesList[index - 1].isActive) {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.w, vertical: 16.h),
                                      width: 1.sw,
                                      height: 100.h,
                                      child: TextStyleGenerator(
                                        text:
                                            "The class that you choose is busy now!!\nChoose another one",
                                        fontSize: 16.sp,
                                        fontWeight: AppFontWeights.medium,
                                      ),
                                    ),
                                  );
                                } else {
                                  router.push(
                                    Routes.chooseClassView,
                                    extra: ChooseClassArguments(
                                      id: viewModel
                                          .classesList[index - 1].docId,
                                    ),
                                  );
                                }
                              },
                              child: ClassContainerWidget(
                                className:
                                    viewModel.classesList[index - 1].docId,
                                isActive:
                                    viewModel.classesList[index - 1].isActive,
                                lectureName:
                                    viewModel.classesList[index - 1].courseName,
                                lecturerName:
                                    viewModel.classesList[index - 1].whoUsing,
                              ),
                            );
                          }
                        }),
                  ),
                ]);
          },
        ),
      ),
    );
  }
}
