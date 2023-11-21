part of 'user_bloc.dart';

@immutable
class UserState {}

class UserNameInitial extends UserState {}

class LoadedAllUsers extends UserState {
  final List<UserModel> users;
  LoadedAllUsers({required this.users});
}

class LoadedMyProfile extends UserState {
  final UserModel profile;
  LoadedMyProfile({required this.profile});
}

class UserSaved extends UserState {}

class UserDeleted extends UserState {}
