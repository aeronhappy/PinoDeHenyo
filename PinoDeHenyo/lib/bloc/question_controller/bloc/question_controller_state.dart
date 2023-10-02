part of 'question_controller_bloc.dart';

class QuestionControllerState {}

class QuestionControllerInitial extends QuestionControllerState {}

class CorrectAnswer extends QuestionControllerState {}

class WrongAnswer extends QuestionControllerState {}

class NextQuestion extends QuestionControllerState {}

class LoadedWritingLevel extends QuestionControllerState {
  final int myLevel;
  LoadedWritingLevel({required this.myLevel});
}

class LoadedWritingQuestion extends QuestionControllerState {
  final List<LessonModel> lessonList;
  LoadedWritingQuestion({required this.lessonList});
}

class LoadedReadingLevel extends QuestionControllerState {
  final int myLevel;
  LoadedReadingLevel({required this.myLevel});
}
