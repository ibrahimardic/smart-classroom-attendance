import 'package:flutter/material.dart';
import 'package:graduation_project/model/attandance_model.dart';
import 'package:graduation_project/model/lectures_model.dart';

class ChooseClassViewModel extends ChangeNotifier {
  final List<LecturesModel> _lecturesList = [
    LecturesModel(
      lectureName: "Artificial Intelligence",
      attandances: [
        AttandanceModel(day: "Tuesdat", date: "10.09.2023"),
        AttandanceModel(day: "Tuesdat", date: "17.09.2023"),
        AttandanceModel(day: "Tuesdat", date: "24.09.2023"),
        AttandanceModel(day: "Tuesdat", date: "01.10.2023"),
        AttandanceModel(day: "Tuesdat", date: "08.10.2023"),
      ],
    ),
    LecturesModel(
      lectureName: "Human Computer Interaction and Usability",
      attandances: [],
    ),
    LecturesModel(
      lectureName: "Computer Network",
      attandances: [],
    ),
    LecturesModel(
      lectureName: "Artificial Intelligence",
      attandances: [],
    ),
    LecturesModel(
      lectureName: "Human Computer Interaction and Usability",
      attandances: [],
    ),
    LecturesModel(
      lectureName: "Computer Network",
      attandances: [],
    ),
  ];
  List<LecturesModel> get lecturesList => _lecturesList;
}
