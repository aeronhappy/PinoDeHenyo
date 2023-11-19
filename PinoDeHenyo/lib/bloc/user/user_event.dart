part of 'user_bloc.dart';

@immutable
class UserEvent {}

class GetAllUserRankingByGame extends UserEvent {
  final String gameName;
  GetAllUserRankingByGame({required this.gameName});
}

class GetMyUserName extends UserEvent {}

class AddUserInList extends UserEvent {
  final String userJsonString;
  AddUserInList({required this.userJsonString});
}
