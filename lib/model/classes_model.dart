class ClassesModel {
  final int id;
  final String className;
  final bool isActive;
  final String? lectureName;
  final String? lecturerName;

  ClassesModel({
    required this.id,
    required this.className,
    required this.isActive,
    this.lectureName,
    this.lecturerName,
  });
}
