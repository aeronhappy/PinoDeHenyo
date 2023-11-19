part of 'user_bloc.dart';

@immutable
class UserState {}

class UserNameInitial extends UserState {}

class LoadedAllUserNameByRanking extends UserState {
  final List<UserModel> users;
  LoadedAllUserNameByRanking({required this.users});
}

class SavedUser extends UserState {}

class LoadedMyProfile extends UserState {
  final UserModel profile;
  LoadedMyProfile({required this.profile});
}
