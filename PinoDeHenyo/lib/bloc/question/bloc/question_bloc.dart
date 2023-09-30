import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pino_de_henyo/model/question_model.dart';
import 'package:pino_de_henyo/repository/contract/i_question_repository.dart';
import 'package:pino_de_henyo/services/contract/i_network_info_services.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final IQuestionRepository questionRepository;
  final INetworkInfoServices networkInfoServices;

  QuestionBloc(
      {required this.questionRepository, required this.networkInfoServices})
      : super(QuestionInitial()) {
    on<GetRandomQuestions>((event, emit) async {
      try {
        emit(LoadingQuestion());
        if (await networkInfoServices.isConnected) {
          List<QuestionModel> randomQuestions = await questionRepository
              .getRandomQuestions(event.numberOfQuestions);
          emit(LoadedRandomQuestions(randomQuestions: randomQuestions));
        } else {
          emit(NoNetworkConnection());
        }
      } catch (e) {
        emit(FailedQuestion(error: e.toString()));
      }
    });
  }
}
