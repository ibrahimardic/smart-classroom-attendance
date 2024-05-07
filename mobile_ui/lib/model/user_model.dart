import 'package:graduation_project/model/classes_model.dart';

class UserModel {
  final String name;
  final int role;
  final List<ClassesModel> classes;
  final Map<dynamic, dynamic>? data;

  UserModel({
    required this.name,
    required this.role,
    required this.classes,
    this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String documentId) {
    List<dynamic> classesData = json['classes'] ?? [];
    List<ClassesModel> classesList = classesData
        .map((classData) => ClassesModel.fromJson(classData))
        .toList();

    return UserModel(
      name: documentId,
      role: json['role'] ?? 0,
      classes: classesList,
      data: json['data'],
    );
  }
}
