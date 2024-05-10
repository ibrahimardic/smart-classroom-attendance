class ClassesModel {
  final String docId;
  final bool isActive;
  final String? courseName;
  final String? whoUsing;
  final List<String> attandedStudents;

  ClassesModel({
    required this.docId,
    required this.isActive,
    required this.attandedStudents,
    this.courseName,
    this.whoUsing,
  });

  factory ClassesModel.fromJson(Map<String, dynamic> json, String docId) {
    List<dynamic> firebaseList = json['attandedStudents'];

    List<String> stringList =
        firebaseList.map((item) => item.toString()).toList();
    return ClassesModel(
      docId: docId,
      isActive: json['isActive'] ?? false,
      courseName: json['courseName'],
      whoUsing: json['whoUsing'],
      attandedStudents: stringList,
    );
  }
}
