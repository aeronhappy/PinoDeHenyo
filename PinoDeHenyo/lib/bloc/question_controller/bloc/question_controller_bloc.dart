import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:pino_de_henyo/model/lesson_model.dart';
import 'package:pino_de_henyo/widgets/others/bg_music.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'question_controller_event.dart';
part 'question_controller_state.dart';

class QuestionControllerBloc
    extends Bloc<QuestionControllerEvent, QuestionControllerState> {
  final SharedPreferences sharedPreferences;
  QuestionControllerBloc({required this.sharedPreferences})
      : super(QuestionControllerInitial()) {
    Random random = new Random();
    on<ClickSubmit>((event, emit) async {
      double effects = sharedPreferences.getDouble('EffectsVolume') ?? 1;

      if (event.isCorrect) {
        await effectsAudioPlayer.play('bg_music/correct_bg.mp3', volume: .2);
        emit(CorrectAnswer());
        return;
      }
      await effectsAudioPlayer.play('bg_music/wrong_bg.mp3', volume: effects);
      emit(WrongAnswer());
    });

    on<ClickNext>((event, emit) {
      emit(NextQuestion());
    });

// WRITING
    on<GetWritingShuffleQuestion>((event, emit) async {
      List<String> savedStrList =
          sharedPreferences.getStringList('writingList') ?? [];
      List<LessonModel> newList = [];

      if (savedStrList.isEmpty) {
        var list = new List<int>.generate(
            lessonList.length, (int index) => index); // [0, 1, 4]
        list.shuffle();
        List<String> strList = list.map((i) => i.toString()).toList();
        sharedPreferences.setStringList("writingList", strList);

        List<String> savedStrList =
            sharedPreferences.getStringList('writingList') ?? [];
        List<int> intProductList =
            savedStrList.map((i) => int.parse(i)).toList();
        for (var item in intProductList) {
          newList.add(lessonList[item]);
        }
        emit(LoadedWritingQuestion(lessonList: newList));
        return;
      }

      List<int> intProductList = savedStrList.map((i) => int.parse(i)).toList();
      for (var item in intProductList) {
        newList.add(lessonList[item]);
      }
      emit(LoadedWritingQuestion(lessonList: newList));
    });

    on<GetWritingLevel>((event, emit) async {
      int myLevel = await sharedPreferences.getInt('WritingLevel') ?? 0;
      emit(LoadedWritingLevel(myLevel: myLevel));
    });

    on<SaveWritingLevel>((event, emit) async {
      await sharedPreferences.setInt('WritingLevel', event.level);
      emit(LoadedWritingLevel(myLevel: event.level));
    });

    on<ChangeWritingLevel>((event, emit) async {
      emit(LoadedWritingLevel(myLevel: event.levelSelected));
    });

// READING
    on<GetReadingLevel>((event, emit) async {
      int myLevel = await sharedPreferences.getInt('ReadingLevel') ?? 0;
      emit(LoadedReadingLevel(myLevel: myLevel));
    });

    on<SaveReadingLevel>((event, emit) async {
      await sharedPreferences.setInt('WritingLevel', event.level);
      emit(LoadedReadingLevel(myLevel: event.level));
    });

    on<ChangeReadingLevel>((event, emit) async {
      emit(LoadedWritingLevel(myLevel: event.levelSelected));
      ;
    });
  }
}
