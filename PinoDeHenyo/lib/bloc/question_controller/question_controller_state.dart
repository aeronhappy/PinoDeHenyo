part of 'question_controller_bloc.dart';

class QuestionControllerState {}

class QuestionControllerInitial extends QuestionControllerState {}

class CorrectAnswer extends QuestionControllerState {}

class WrongAnswer extends QuestionControllerState {}

class NextQuestion extends QuestionControllerState {}

class LoadedCategory extends QuestionControllerState {
  final List<String> category;
  LoadedCategory({required this.category});
}

class LoadedLessonByCategory extends QuestionControllerState {
  final List<LessonCategoryModel> categoryLessonList;
  LoadedLessonByCategory({required this.categoryLessonList});
}

// WRITING
class LoadedWritingLevel extends QuestionControllerState {
  final int myLevel;
  LoadedWritingLevel({required this.myLevel});
}

class LoadedWritingSelected extends QuestionControllerState {
  final int level;
  LoadedWritingSelected({required this.level});
}

class LoadedWritingQuestion extends QuestionControllerState {
  final List<LessonCategoryModel> lessonList;
  LoadedWritingQuestion({required this.lessonList});
}

// READING
class LoadedReadingLevel extends QuestionControllerState {
  final int myLevel;
  LoadedReadingLevel({required this.myLevel});
}

class LoadedReadingSelected extends QuestionControllerState {
  final int level;
  LoadedReadingSelected({required this.level});
}

class LoadedReadingQuestion extends QuestionControllerState {
  final List<LessonCategoryModel> lessonList;
  LoadedReadingQuestion({required this.lessonList});
}

// QUIZ
class LoadedQuizLevel extends QuestionControllerState {
  final int myLevel;
  LoadedQuizLevel({required this.myLevel});
}

class LoadedQuizSelected extends QuestionControllerState {
  final int level;
  LoadedQuizSelected({required this.level});
}

class LoadedQuizQuestion extends QuestionControllerState {
  final List<LessonCategoryModel> lessonList;
  LoadedQuizQuestion({required this.lessonList});
}

class LoadedQuizChoices extends QuestionControllerState {
  final List<String> choices;
  LoadedQuizChoices({required this.choices});
}
