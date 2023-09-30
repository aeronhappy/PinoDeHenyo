import 'package:bloc/bloc.dart';
part 'question_controller_event.dart';
part 'question_controller_state.dart';

class QuestionControllerBloc
    extends Bloc<QuestionControllerEvent, QuestionControllerState> {
  QuestionControllerBloc() : super(QuestionControllerInitial()) {
    on<ClickSubmit>((event, emit) {
      if (event.isCorrect) {
        emit(CorrectAnswer());
        return;
      }
      emit(WrongAnswer());
    });

    on<ClickNext>((event, emit) {
      emit(NextQuestion());
    });
  }
}
