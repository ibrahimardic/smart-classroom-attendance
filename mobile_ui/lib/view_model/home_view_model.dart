import 'package:flutter/material.dart';
import 'package:graduation_project/model/classes_model.dart';
import 'package:graduation_project/model/user_model.dart';

class HomeViewModel extends ChangeNotifier {
  final List<ClassesModel> _classesList = [
    ClassesModel(docId: "D-401", isActive: false),
    ClassesModel(
      docId: "D-402",
      isActive: true,
      courseName: "Human Computer Interaction and Usability",
      whoUsing: "Yılmaz Kemal Yüce",
    ),
    ClassesModel(docId: "D-403", isActive: false),
    ClassesModel(docId: "D-404", isActive: false),
    ClassesModel(
      docId: "D-405",
      isActive: true,
      courseName: "Data Structures and Algorithms",
      whoUsing: "Kübra Uyar",
    ),
    ClassesModel(docId: "D-406", isActive: false),
    ClassesModel(docId: "D-407", isActive: false),
    ClassesModel(docId: "D-408", isActive: false),
    ClassesModel(
      docId: "D-409",
      isActive: true,
      courseName: "Basic Principles of Image Processing",
      whoUsing: "Özge Öztimur Karadağ",
    ),
  ];

  List<UserModel> attandedStudents = [
    //   StudentModel(id: "180254037", name: "Batuhan", surname: "Yıldızhan"),
    //   StudentModel(id: "180254050", name: "İbrahim", surname: "Ardıç"),
    //   StudentModel(id: "180254037", name: "Batuhan", surname: "Yıldızhan"),
    //   StudentModel(id: "180254050", name: "İbrahim", surname: "Ardıç"),
    //   StudentModel(id: "180254037", name: "Batuhan", surname: "Yıldızhan"),
    //   StudentModel(id: "180254050", name: "İbrahim", surname: "Ardıç"),
    //   StudentModel(id: "180254037", name: "Batuhan", surname: "Yıldızhan"),
    //   StudentModel(id: "180254050", name: "İbrahim", surname: "Ardıç"),
  ];

  String? _activeClass = null;

  String? get activeClass => _activeClass;
  List<ClassesModel> get classesList => _classesList;

  setActiveClass(String? className) {
    _activeClass = className;
    notifyListeners();
  }

  deleteStudentFromAttandance(int index) {
    //   attandedStudents.removeAt(index);
    //   notifyListeners();
  }
}
