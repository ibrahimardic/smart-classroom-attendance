class ClassesModel {
  final String docId;
  final bool isActive;
  final String? courseName;
  final String? whoUsing;

  ClassesModel({
    required this.docId,
    required this.isActive,
    this.courseName,
    this.whoUsing,
  });

  factory ClassesModel.fromJson(Map<String, dynamic> json) {
    return ClassesModel(
      docId: json['docId'] ?? '',
      isActive: json['isActive'] ?? false,
      courseName: json['courseName'],
      whoUsing: json['whoUsing'],
    );
  }
}
