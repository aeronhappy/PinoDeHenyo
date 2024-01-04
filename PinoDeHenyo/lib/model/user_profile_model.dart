class UserModel {
  final String deviceId;
  final String userName;
  final int writingLevel;
  final int readingLevel;
  final int quizLevel;

  UserModel(
      {required this.deviceId,
      required this.userName,
      required this.writingLevel,
      required this.readingLevel,
      required this.quizLevel});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      deviceId: json['deviceId'],
      userName: json['userName'],
      writingLevel: json['writingLevel'],
      readingLevel: json['readingLevel'],
      quizLevel: json['quizLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': this.deviceId,
      'userName': this.userName,
      'writingLevel': this.writingLevel,
      'readingLevel': this.readingLevel,
      'quizLevel': this.quizLevel,
    };
  }
}
