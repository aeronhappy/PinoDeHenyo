part of 'user_bloc.dart';

@immutable
class UserEvent {}

class GetAllUserRankingByGame extends UserEvent {
  final String gameName;
  GetAllUserRankingByGame({required this.gameName});
}

class GetMyUserName extends UserEvent {}

// class GetUserNameByReading extends UserNameEvent {}

// class GetUserNameByWritting extends UserNameEvent {}

// class GetUserNameByQuiz extends UserNameEvent {}
