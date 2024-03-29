import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pino_de_henyo/bloc/teacher/teacher_bloc.dart';
import 'package:pino_de_henyo/bloc/user/user_bloc.dart';
import 'package:pino_de_henyo/helper/api_helper.dart' as api_helper;
import 'package:pino_de_henyo/repository/injection_container.dart' as di;
import 'package:pino_de_henyo/repository/injection_container.dart';
import 'package:pino_de_henyo/views/dashboard_page.dart';
import 'package:pino_de_henyo/views/menu_page.dart';
import 'package:pino_de_henyo/views/teacher_profile_page.dart';
import 'package:pino_de_henyo/widgets/device_id.dart';
import 'package:pino_de_henyo/widgets/music.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.delayed(Duration(seconds: 1));
  FlutterNativeSplash.remove();

  api_helper.initializeClient(token: '');
  await di.init();
  var sharedPref = await SharedPreferences.getInstance();

  bool isStarted = await sharedPref.getBool('doneOnboarding') ?? false;
  String position = await sharedPref.getString('position') ?? "";
  int teacherId = await sharedPref.getInt("teacherId") ?? -1;
  runApp(MyApp(
    isStarted: isStarted,
    position: position,
    hasTeacher: teacherId == -1 ? false : true,
  ));
}

class MyApp extends StatefulWidget {
  final bool isStarted;
  final String position;
  final bool hasTeacher;
  const MyApp(
      {super.key,
      required this.isStarted,
      required this.position,
      required this.hasTeacher});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late AppLifecycleState appLifecycle;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      audioP.stop();
    }
    if (state == AppLifecycleState.resumed) {
      playMusic();
    }
  }

  initState() {
    super.initState();
    playMusic();
    WidgetsBinding.instance.addObserver(this);
    saveDeviceInfo();
  }

  saveDeviceInfo() async {
    var sharedPref = await SharedPreferences.getInstance();
    String device = await getDeviceId() ?? "no device";
    await sharedPref.setString("deviceInfo", device);
  }

  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pino De Henyo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: widget.isStarted
          ? widget.position == "teacher"
              ? MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => TeacherBloc(sharedPreferences: sl()),
                    ),
                    BlocProvider(
                      create: (context) => UserBloc(sharedPreferences: sl()),
                    ),
                  ],
                  child: TeacherProfilePage(),
                )
              : DashboardPage()
          : MenuPage(),
    );
  }
}
