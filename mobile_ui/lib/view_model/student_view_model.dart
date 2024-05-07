import 'package:flutter/material.dart';
import 'package:graduation_project/model/user_model.dart';

class StudentViewModel extends ChangeNotifier {
  final List<UserModel> _attandances = [
    // UserModel(
    //   name: "Artificial Intelligence",
    //   attandances: [
    //     AttandanceModel(day: "Tuesdat", date: "10.09.2023"),
    //     AttandanceModel(day: "Tuesdat", date: "17.09.2023"),
    //     AttandanceModel(day: "Tuesdat", date: "24.09.2023"),
    //     AttandanceModel(day: "Tuesdat", date: "01.10.2023"),
    //     AttandanceModel(day: "Tuesdat", date: "08.10.2023"),
    //   ],
    // ),
    // UserModel(
    //   name: "Human Computer Interaction",
    //   attandances: [],
    // ),
    // UserModel(
    //   name: "Computer Network",
    //   attandances: [],
    // ),
    // UserModel(
    //   name: "Artificial Intelligence",
    //   attandances: [],
    // ),
    // UserModel(
    //   name: "Human Computer Interaction",
    //   attandances: [],
    // ),
    // UserModel(
    //   name: "Computer Network",
    //   attandances: [],
    // ),
  ];

  bool _isDetailed = false;

  bool get isDetailed => _isDetailed;
  List<UserModel> get attandances => _attandances;

  changeIsDetailed() {
    _isDetailed = !_isDetailed;
    notifyListeners();
  }
}
