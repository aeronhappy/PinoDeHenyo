part of 'teacher_bloc.dart';

class TeacherEvent {}

class LoginTeacherAccount extends TeacherEvent {
  final String userName;
  final String password;
  LoginTeacherAccount({required this.userName, required this.password});
}

class GetMyAccount extends TeacherEvent {}

class CreateTeacherAccount extends TeacherEvent {
  final TeacherModel teacherModel;
  CreateTeacherAccount({required this.teacherModel});
}

class ChangeTeacherInfo extends TeacherEvent {
  final TeacherModel teacherModel;
  ChangeTeacherInfo({required this.teacherModel});
}

class LogoutTeacherAccount extends TeacherEvent {}
