class UserModel {
  final String userName;
  final int writingLevel;
  final int readingLevel;
  final int quizLevel;

  UserModel(
      {required this.userName,
      required this.writingLevel,
      required this.readingLevel,
      required this.quizLevel});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'],
      writingLevel: json['writingLevel'],
      readingLevel: json['readingLevel'],
      quizLevel: json['quizLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': this.userName,
      'writingLevel': this.writingLevel,
      'readingLevel': this.readingLevel,
      'quizLevel': this.quizLevel,
    };
  }
}

List<UserModel> allUsers = <UserModel>[
  UserModel(
      userName: "Aeron Darelle Maligaya",
      writingLevel: 2,
      readingLevel: 3,
      quizLevel: 5),
  UserModel(
      userName: "Hanna Cuelo", writingLevel: 12, readingLevel: 2, quizLevel: 5),
  UserModel(
      userName: "Marjorie Malijan",
      writingLevel: 3,
      readingLevel: 5,
      quizLevel: 1),
  UserModel(
      userName: "Arjay Maligaya",
      writingLevel: 11,
      readingLevel: 1,
      quizLevel: 2),
  UserModel(
      userName: "Dianne Dingcol",
      writingLevel: 4,
      readingLevel: 3,
      quizLevel: 5),
];
