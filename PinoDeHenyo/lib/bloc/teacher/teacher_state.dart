part of 'teacher_bloc.dart';

class TeacherState {}

class TeacherInitial extends TeacherState {}

class LoadingTeacherState extends TeacherState {}

class LoginFailed extends TeacherState {}

class LoginSuccessful extends TeacherState {}

class SuccessfullyCreated extends TeacherState {}

class FailedCreateAccount extends TeacherState {}

class TeacherInfoChanged extends TeacherState {}

class LogoutAccount extends TeacherState {}

class LoadedMyAccount extends TeacherState {
  final TeacherModel teacherModel;
  LoadedMyAccount({required this.teacherModel});
}
