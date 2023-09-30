import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_app/bloc/question/bloc/question_bloc.dart';
import 'package:youtube_app/repository/contract/i_question_repository.dart';
import 'package:youtube_app/repository/implementation/question_repository.dart';
import 'package:youtube_app/services/contract/i_network_info_services.dart';
import 'package:youtube_app/services/implementation/network_info_services.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
// Prio
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<INetworkInfoServices>(
      () => NetworkInfoServices(sl()));
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //Bloc Registration
  sl.registerFactory(
      () => QuestionBloc(questionRepository: sl(), networkInfoServices: sl()));

  //Repository Registration
  sl.registerLazySingleton<IQuestionRepository>(() => QuestionRepository());
}
