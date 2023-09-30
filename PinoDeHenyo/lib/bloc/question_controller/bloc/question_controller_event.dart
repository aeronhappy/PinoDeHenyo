part of 'question_controller_bloc.dart';

class QuestionControllerEvent {}

class ClickSubmit extends QuestionControllerEvent {
  final bool isCorrect;
  ClickSubmit({required this.isCorrect});
}

class ClickNext extends QuestionControllerEvent {}
