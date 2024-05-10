class UserModel {
  final String name;
  final int role;
  final String? activeClass;
  final List<String> courses;

  UserModel({
    required this.name,
    required this.role,
    required this.activeClass,
    required this.courses,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> firebaseList = json['courses'];

    List<String> stringList =
        firebaseList.map((item) => item.toString()).toList();
    return UserModel(
      name: json['name'],
      role: json['role'],
      activeClass: json['activeClass'],
      courses: stringList,
    );
  }
}
