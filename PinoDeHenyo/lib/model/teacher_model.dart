class TeacherModel {
  final int id;
  final String firstName;
  final String lastName;
  final bool gender;
  final String userName;
  final String password;

  TeacherModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.userName,
    required this.password,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'] as bool,
      userName: json['userName'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'gender': this.gender,
      'userName': this.userName,
      'password': this.password,
    };
  }
}

List<TeacherModel> teachers = [
  TeacherModel(
      id: 1,
      firstName: "Aeron Darelle",
      lastName: "Maligaya",
      gender: true,
      userName: "aeronhappy",
      password: "aeronaeron123"),
  TeacherModel(
      id: 2,
      firstName: "Hanna",
      lastName: "Caila",
      gender: false,
      userName: "hannacaila",
      password: "hannahanna123"),
];
