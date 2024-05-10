import 'package:flutter/material.dart';
import 'package:graduation_project/model/classes_model.dart';
import 'package:graduation_project/model/user_model.dart';
import 'package:graduation_project/service/home/home_service.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    getUserData();
    getClasses();
  }

  HomeService homeService = HomeService();

  UserModel? _user;
  bool _isLoading = false;

  List<ClassesModel> _classesList = [];
  List<String> _attandedStudents = [];

  List<ClassesModel> get classesList => _classesList;
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  List<String> get attandedStudents => _attandedStudents;

  deleteStudentFromAttandance(int index) {
    //   attandedStudents.removeAt(index);
    //   notifyListeners();
  }

  getUserData() async {
    _isLoading = true;
    notifyListeners();

    _user = await homeService.getUserData();

    _isLoading = false;
    notifyListeners();
  }

  getClasses() async {
    _isLoading = true;
    notifyListeners();

    _classesList = await homeService.getClasses();

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> setClassActive(String docId, String lectureName) async {
    if (user!.activeClass == null) {
      _isLoading = true;
      notifyListeners();

      bool response =
          await homeService.setClassroomActive(docId, lectureName, user!.name);

      _isLoading = false;
      notifyListeners();
      return response;
    } else {
      return false;
    }
  }

  Future<bool> setClassroomDeactive() async {
    _isLoading = true;
    notifyListeners();
    print(_user!);
    bool response = await homeService.setClassroomDeactive(_user!.activeClass!);

    _isLoading = false;
    notifyListeners();
    return response;
  }

  Future getAttandedStudents() async {
    _isLoading = true;
    notifyListeners();

    _attandedStudents =
        await homeService.getAttandedStudents(user!.activeClass!);
    print(_attandedStudents);
    _isLoading = false;
    notifyListeners();
  }
}
