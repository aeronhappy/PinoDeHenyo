import 'package:pino_de_henyo/model/question_model.dart';

abstract class IQuestionRepository {
  Future<List<QuestionModel>> getRandomQuestions(int numberOfQuestions);
}
