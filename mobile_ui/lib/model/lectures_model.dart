import 'package:graduation_project/model/attandance_model.dart';

class LecturesModel {
  final String lectureName;
  final List<AttandanceModel> attandances;
  LecturesModel({
    required this.lectureName,
    required this.attandances,
  });
}
