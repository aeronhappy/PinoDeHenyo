import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pino_de_henyo/model/lesson_category_model.dart';
import 'package:pino_de_henyo/widgets/music.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'question_controller_event.dart';
part 'question_controller_state.dart';

class QuestionControllerBloc
    extends Bloc<QuestionControllerEvent, QuestionControllerState> {
  final SharedPreferences sharedPreferences;
  QuestionControllerBloc({required this.sharedPreferences})
      : super(QuestionControllerInitial()) {
    on<ClickSubmit>((event, emit) async {
      double effects = sharedPreferences.getDouble('EffectsVolume') ?? 1;

      if (event.isCorrect) {
        await effectsAudioPlayer.play('bg_music/correct_bg.mp3',
            volume: effects);
        emit(CorrectAnswer());
        return;
      }
      await effectsAudioPlayer.play('bg_music/wrong_bg.mp3', volume: effects);
      emit(WrongAnswer());
    });

    on<ClickNext>((event, emit) {
      emit(NextQuestion());
    });

    on<GetListCategory>((event, emit) {
      Set<String> category = Set();
      for (var item in lessonCategoryList) {
        category.add(item.id);
      }

      emit(LoadedCategory(category: category.toList()));
    });

    on<GetLessonByCategory>((event, emit) async {
      List<LessonCategoryModel> newList = [];
      for (var item in lessonCategoryList) {
        PaletteGenerator paletteGenerator =
            await PaletteGenerator.fromImageProvider(
                Image.asset(item.image).image);
        if (item.id == event.category) {
          var newItem = LessonCategoryModel(
              id: item.id,
              title: item.title,
              description: item.description,
              example: item.example,
              image: item.image,
              color: paletteGenerator.dominantColor!.color.withOpacity(.9));
          newList.add(newItem);
        }
      }
      print(newList.length);
      emit(LoadedLessonByCategory(categoryLessonList: newList));
    });

// WRITING
    on<GetWritingShuffleQuestion>((event, emit) async {
      List<String> savedStrList =
          sharedPreferences.getStringList('writingList') ?? [];
      List<LessonCategoryModel> newList = [];

      if (savedStrList.isEmpty) {
        var list = new List<int>.generate(
            lessonCategoryList.length, (int index) => index); // [0, 1, 4]
        list.shuffle();
        List<String> strList = list.map((i) => i.toString()).toList();
        sharedPreferences.setStringList("writingList", strList);

        List<String> savedStrList =
            sharedPreferences.getStringList('writingList') ?? [];
        List<int> intProductList =
            savedStrList.map((i) => int.parse(i)).toList();
        for (var item in intProductList) {
          newList.add(lessonCategoryList[item]);
        }
        emit(LoadedWritingQuestion(lessonList: newList));
        return;
      }

      List<int> intProductList = savedStrList.map((i) => int.parse(i)).toList();
      for (var item in intProductList) {
        newList.add(lessonCategoryList[item]);
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
      emit(LoadedWritingSelected(level: event.levelSelected));
    });

// READING
    on<GetReadingShuffleQuestion>((event, emit) async {
      List<String> savedStrList =
          sharedPreferences.getStringList('readingList') ?? [];
      List<LessonCategoryModel> newList = [];

      if (savedStrList.isEmpty) {
        var list = new List<int>.generate(
            lessonCategoryList.length, (int index) => index); // [0, 1, 4]
        list.shuffle();
        List<String> strList = list.map((i) => i.toString()).toList();
        sharedPreferences.setStringList("readingList", strList);

        List<String> savedStrList =
            sharedPreferences.getStringList('readingList') ?? [];
        List<int> intProductList =
            savedStrList.map((i) => int.parse(i)).toList();
        for (var item in intProductList) {
          newList.add(lessonCategoryList[item]);
        }
        emit(LoadedReadingQuestion(lessonList: newList));
        return;
      }

      List<int> intProductList = savedStrList.map((i) => int.parse(i)).toList();
      for (var item in intProductList) {
        newList.add(lessonCategoryList[item]);
      }
      emit(LoadedReadingQuestion(lessonList: newList));
    });

    on<GetReadingLevel>((event, emit) async {
      int myLevel = await sharedPreferences.getInt('ReadingLevel') ?? 0;
      emit(LoadedReadingLevel(myLevel: myLevel));
    });

    on<SaveReadingLevel>((event, emit) async {
      await sharedPreferences.setInt('ReadingLevel', event.level);
      emit(LoadedReadingLevel(myLevel: event.level));
    });

    on<ChangeReadingLevel>((event, emit) async {
      emit(LoadedReadingSelected(level: event.levelSelected));
      ;
    });

// QUIZ
    on<GetQuizQuestion>((event, emit) async {
      List<String> savedStrList =
          sharedPreferences.getStringList('quizList') ?? [];
      List<LessonCategoryModel> newList = [];
      int myLevel = await sharedPreferences.getInt('QuizLevel') ?? 0;

      if (savedStrList.isEmpty) {
        var list = new List<int>.generate(
            lessonCategoryList.length, (int index) => index); // [0, 1, 4]
        list.shuffle();
        List<String> strList = list.map((i) => i.toString()).toList();
        sharedPreferences.setStringList("quizList", strList);

        List<String> savedStrList =
            sharedPreferences.getStringList('quizList') ?? [];
        List<int> intProductList =
            savedStrList.map((i) => int.parse(i)).toList();
        for (var item in intProductList) {
          newList.add(lessonCategoryList[item]);
        }
        emit(LoadedReadingQuestion(lessonList: newList));

        add(GetQuizChoices(answer: newList[myLevel].title));
        return;
      }

      List<int> intProductList = savedStrList.map((i) => int.parse(i)).toList();
      for (var item in intProductList) {
        newList.add(lessonCategoryList[item]);
      }
      emit(LoadedQuizQuestion(lessonList: newList));
      add(GetQuizChoices(answer: newList[myLevel].title));
    });

    on<GetQuizLevel>((event, emit) async {
      int myLevel = await sharedPreferences.getInt('QuizLevel') ?? 0;
      emit(LoadedQuizLevel(myLevel: myLevel));
    });

    on<SaveQuizLevel>((event, emit) async {
      await sharedPreferences.setInt('QuizLevel', event.level);
      emit(LoadedQuizLevel(myLevel: event.level));
    });

    on<ChangeQuizLevel>((event, emit) async {
      emit(LoadedQuizSelected(level: event.levelSelected));
      ;
    });

    on<GetQuizChoices>((event, emit) async {
      int myLevel = await sharedPreferences.getInt('QuizLevel') ?? 0;
      List<String> choices = [];
      choices.add(event.answer);
      List<LessonCategoryModel> newList = [];
      var list = new List<int>.generate(
          lessonCategoryList.length, (int index) => index);
      list.shuffle();
      for (var item in list) {
        newList.add(lessonCategoryList[item]);
      }
      list.remove(myLevel);

      for (var i = 0; i < 3; i++) {
        choices.add(newList[i].title);
      }
      choices.shuffle();
      emit(LoadedQuizChoices(choices: choices));
    });
  }
}
