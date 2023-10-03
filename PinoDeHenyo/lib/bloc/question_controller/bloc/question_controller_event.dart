part of 'question_controller_bloc.dart';

class QuestionControllerEvent {}

class ClickSubmit extends QuestionControllerEvent {
  final bool isCorrect;
  ClickSubmit({required this.isCorrect});
}

class ClickNext extends QuestionControllerEvent {}

class GetListCategory extends QuestionControllerEvent {}

class GetLessonByCategory extends QuestionControllerEvent {
  final String category;
  GetLessonByCategory({required this.category});
}

// WRITING
class GetWritingShuffleQuestion extends QuestionControllerEvent {}

class GetWritingLevel extends QuestionControllerEvent {}

class SaveWritingLevel extends QuestionControllerEvent {
  final int level;
  SaveWritingLevel({required this.level});
}

class ChangeWritingLevel extends QuestionControllerEvent {
  final int levelSelected;
  ChangeWritingLevel({required this.levelSelected});
}

// READING
class GetReadingShuffleQuestion extends QuestionControllerEvent {}

class GetReadingLevel extends QuestionControllerEvent {}

class SaveReadingLevel extends QuestionControllerEvent {
  final int level;
  SaveReadingLevel({required this.level});
}

class ChangeReadingLevel extends QuestionControllerEvent {
  final int levelSelected;
  ChangeReadingLevel({required this.levelSelected});
}

///QUIZ

class GetQuizQuestion extends QuestionControllerEvent {}

class GetQuizLevel extends QuestionControllerEvent {}

class SaveQuizLevel extends QuestionControllerEvent {
  final int level;
  SaveQuizLevel({required this.level});
}

class ChangeQuizLevel extends QuestionControllerEvent {
  final int levelSelected;
  ChangeQuizLevel({required this.levelSelected});
}

class GetQuizChoices extends QuestionControllerEvent {
  final String answer;
  GetQuizChoices({required this.answer});
}
