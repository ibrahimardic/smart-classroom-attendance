import 'package:flutter/material.dart';
import 'package:graduation_project/model/user_model.dart';

class ChooseClassViewModel extends ChangeNotifier {
  final List<UserModel> _lecturesList = [
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
    //   name: "Human Computer Interaction and Usability",
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
    //   name: "Human Computer Interaction and Usability",
    //   attandances: [],
    // ),
    // UserModel(
    //   name: "Computer Network",
    //   attandances: [],
    //),
  ];
  List<UserModel> get lecturesList => _lecturesList;
}
