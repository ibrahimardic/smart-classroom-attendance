import 'package:flutter/material.dart';
import 'package:graduation_project/model/classes_model.dart';
import 'package:graduation_project/model/student_model.dart';

class HomeViewModel extends ChangeNotifier {
  final List<ClassesModel> _classesList = [
    ClassesModel(id: 0, className: "D-401", isActive: false),
    ClassesModel(
      id: 1,
      className: "D-402",
      isActive: true,
      lectureName: "Human Computer Interaction and Usability",
      lecturerName: "Yılmaz Kemal Yüce",
    ),
    ClassesModel(id: 2, className: "D-403", isActive: false),
    ClassesModel(id: 3, className: "D-404", isActive: false),
    ClassesModel(
      id: 4,
      className: "D-405",
      isActive: true,
      lectureName: "Data Structures and Algorithms",
      lecturerName: "Kübra Uyar",
    ),
    ClassesModel(id: 5, className: "D-406", isActive: false),
    ClassesModel(id: 6, className: "D-407", isActive: false),
    ClassesModel(id: 7, className: "D-408", isActive: false),
    ClassesModel(
      id: 8,
      className: "D-409",
      isActive: true,
      lectureName: "Basic Principles of Image Processing",
      lecturerName: "Özge Öztimur Karadağ",
    ),
  ];

  List<StudentModel> attandedStudents = [
    StudentModel(id: "180254037", name: "Batuhan", surname: "Yıldızhan"),
    StudentModel(id: "180254050", name: "İbrahim", surname: "Ardıç"),
    StudentModel(id: "180254037", name: "Batuhan", surname: "Yıldızhan"),
    StudentModel(id: "180254050", name: "İbrahim", surname: "Ardıç"),
    StudentModel(id: "180254037", name: "Batuhan", surname: "Yıldızhan"),
    StudentModel(id: "180254050", name: "İbrahim", surname: "Ardıç"),
    StudentModel(id: "180254037", name: "Batuhan", surname: "Yıldızhan"),
    StudentModel(id: "180254050", name: "İbrahim", surname: "Ardıç"),
  ];

  String? _activeClass = null;

  String? get activeClass => _activeClass;
  List<ClassesModel> get classesList => _classesList;

  setActiveClass(String? className) {
    _activeClass = className;
    notifyListeners();
  }

  deleteStudentFromAttandance(int index) {
    attandedStudents.removeAt(index);
    notifyListeners();
  }
}
