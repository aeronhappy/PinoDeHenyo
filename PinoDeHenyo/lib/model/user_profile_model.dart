import 'dart:typed_data';

class UserModel {
  final String userName;
  // final Uint8List? myBytes;
  final int writingLevel;
  final int readingLevel;
  final int quizLevel;

  UserModel(
      {required this.userName,
      // required this.myBytes,
      required this.writingLevel,
      required this.readingLevel,
      required this.quizLevel});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'],
      // myBytes: json['myBytes'],
      writingLevel: json['writingLevel'],
      readingLevel: json['readingLevel'],
      quizLevel: json['quizLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': this.userName,
      // 'myBytes': this.myBytes,
      'writingLevel': this.writingLevel,
      'readingLevel': this.readingLevel,
      'quizLevel': this.quizLevel,
    };
  }
}
