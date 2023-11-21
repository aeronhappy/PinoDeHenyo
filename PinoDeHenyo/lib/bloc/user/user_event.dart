part of 'user_bloc.dart';

@immutable
class UserEvent {}

class GetMyUserName extends UserEvent {}

class GetAllUsers extends UserEvent {}

class GetAllUserRankingByGame extends UserEvent {
  final String gameName;
  GetAllUserRankingByGame({required this.gameName});
}

class AddUserInList extends UserEvent {
  final String userJsonString;
  AddUserInList({required this.userJsonString});
}

class DeleteUserById extends UserEvent {
  final String userId;
  DeleteUserById({required this.userId});
}
