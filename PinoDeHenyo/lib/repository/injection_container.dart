import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pino_de_henyo/bloc/question_controller/question_controller_bloc.dart';
import 'package:pino_de_henyo/bloc/user/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pino_de_henyo/services/contract/i_network_info_services.dart';
import 'package:pino_de_henyo/services/implementation/network_info_services.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
// Prio
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<INetworkInfoServices>(
      () => NetworkInfoServices(sl()));
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //Bloc Registration
  sl.registerFactory(() => QuestionControllerBloc(sharedPreferences: sl()));
  sl.registerFactory(() => UserBloc(sharedPreferences: sl()));
}
