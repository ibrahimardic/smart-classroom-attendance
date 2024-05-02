import 'package:flutter/material.dart';
import 'package:graduation_project/model/attandance_model.dart';
import 'package:graduation_project/model/lectures_model.dart';

class StudentViewModel extends ChangeNotifier {
  final List<LecturesModel> _attandances = [
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
      lectureName: "Human Computer Interaction",
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
      lectureName: "Human Computer Interaction",
      attandances: [],
    ),
    LecturesModel(
      lectureName: "Computer Network",
      attandances: [],
    ),
  ];

  bool _isDetailed = false;

  bool get isDetailed => _isDetailed;
  List<LecturesModel> get attandances => _attandances;

  changeIsDetailed() {
    _isDetailed = !_isDetailed;
    notifyListeners();
  }
}
