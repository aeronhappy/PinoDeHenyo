import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pino_de_henyo/model/game_model.dart';
import 'package:pino_de_henyo/model/user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SharedPreferences sharedPreferences;
  UserBloc({required this.sharedPreferences}) : super(UserNameInitial()) {
    on<GetAllUserRankingByGame>((event, emit) async {
      List<UserModel> users = [];

      final jsonString = sharedPreferences.getString('listOfUser');
      if (jsonString != null) {
        final decoded = json.decode(jsonString);
        users = await Future.value(
            decoded.map<UserModel>((e) => UserModel.fromJson(e)).toList());
      }

      if (event.gameName == gameName[0]) {
        users.sort((b, a) => a.writingLevel.compareTo(b.writingLevel));
      }
      if (event.gameName == gameName[1]) {
        users.sort((b, a) => a.readingLevel.compareTo(b.readingLevel));
      }
      if (event.gameName == gameName[2]) {
        users.sort((b, a) => a.quizLevel.compareTo(b.quizLevel));
      }

      emit(LoadedAllUserNameByRanking(users: users));
    });

    on<AddUserInList>((event, emit) async {
      List<UserModel> users = [];

      final jsonString = sharedPreferences.getString('listOfUser');
      if (jsonString != null) {
        final decoded = json.decode(jsonString);
        users = await Future.value(
            decoded.map<UserModel>((e) => UserModel.fromJson(e)).toList());
      }

      UserModel user = UserModel.fromJson(jsonDecode(event.userJsonString));
      users.removeWhere((item) => item.userName == user.userName);
      users.add(user);
      String userString = jsonEncode(users);
      sharedPreferences.setString('listOfUser', userString);
      emit(SavedUser());
    });
  }
}
