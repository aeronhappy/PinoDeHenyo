import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:pino_de_henyo/model/teacher_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  final SharedPreferences sharedPreferences;
  TeacherBloc({required this.sharedPreferences}) : super(TeacherInitial()) {
    //

    on<GetMyAccount>((event, emit) async {
      List<TeacherModel> teachersAccount = [];
      final jsonString = sharedPreferences.getString('listOfTeachersAccount');
      if (jsonString != null) {
        final decoded = json.decode(jsonString);
        teachersAccount = await Future.value(decoded
            .map<TeacherModel>((e) => TeacherModel.fromJson(e))
            .toList());
      }
      int teacherId = sharedPreferences.getInt("teacherId") ?? -1;

      var teacherIndex =
          teachersAccount.indexWhere((element) => element.id == teacherId);

      var myAccount = teachersAccount[teacherIndex];
      emit(LoadedMyAccount(teacherModel: myAccount));
    });

    on<LoginTeacherAccount>((event, emit) async {
      List<TeacherModel> teachersAccount = [];

      final jsonString = sharedPreferences.getString('listOfTeachersAccount');

      if (jsonString != null) {
        final decoded = json.decode(jsonString);
        teachersAccount = await Future.value(decoded
            .map<TeacherModel>((e) => TeacherModel.fromJson(e))
            .toList());
      } else {
        teachersAccount.add(teachers[0]);
        teachersAccount.add(teachers[1]);

        String teacherAccountString = jsonEncode(teachersAccount);
        sharedPreferences.setString(
            'listOfTeachersAccount', teacherAccountString);
      }

      var teacherIndex = teachersAccount
          .indexWhere((element) => element.userName == event.userName);

      if (teacherIndex == -1) {
        emit(LoginFailed());
        return;
      } else {
        if (teachersAccount[teacherIndex].password == event.password) {
          sharedPreferences.setInt(
              "teacherId", teachersAccount[teacherIndex].id);
          sharedPreferences.setBool("doneOnboarding", true);
          emit(LoginSuccessful());
          return;
        } else {
          emit(LoginFailed());
          return;
        }
      }
    });

    on<CreateTeacherAccount>((event, emit) async {
      List<TeacherModel> teachersAccount = [];
      final jsonString = sharedPreferences.getString('listOfTeachersAccount');
      if (jsonString != null) {
        final decoded = json.decode(jsonString);
        teachersAccount = await Future.value(decoded
            .map<TeacherModel>((e) => TeacherModel.fromJson(e))
            .toList());
      }
      var teacherIndex = teachersAccount.indexWhere(
          (element) => element.userName == event.teacherModel.userName);

      if (teacherIndex == -1) {
        var newUserId = teachersAccount.length + 1;
        teachersAccount.add(TeacherModel(
            id: newUserId,
            firstName: event.teacherModel.firstName,
            lastName: event.teacherModel.lastName,
            gender: event.teacherModel.gender,
            userName: event.teacherModel.userName,
            password: event.teacherModel.password));
        String teacherAccountString = jsonEncode(teachersAccount);
        sharedPreferences.setString(
            'listOfTeachersAccount', teacherAccountString);
        emit(SuccessfullyCreated());
        return;
      } else {
        emit(FailedCreateAccount());
        return;
      }
    });

    on<ChangeTeacherInfo>((event, emit) async {
      List<TeacherModel> teachersAccount = [];
      final jsonString = sharedPreferences.getString('listOfTeachersAccount');
      if (jsonString != null) {
        final decoded = json.decode(jsonString);
        teachersAccount = await Future.value(decoded
            .map<TeacherModel>((e) => TeacherModel.fromJson(e))
            .toList());
      }
      teachersAccount
          .removeWhere((element) => element.id == event.teacherModel.id);
      teachersAccount.add(event.teacherModel);
      String teacherAccountString = jsonEncode(teachersAccount);
      sharedPreferences.setString(
          'listOfTeachersAccount', teacherAccountString);
      emit(TeacherInfoChanged());
      emit(LoadedMyAccount(teacherModel: event.teacherModel));
    });

    on<LogoutTeacherAccount>((event, emit) async {
      sharedPreferences.remove("teacherId");
      emit(LogoutAccount());
    });
  }
}
