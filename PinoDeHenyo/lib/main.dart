import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pino_de_henyo/helper/api_helper.dart' as api_helper;
import 'package:pino_de_henyo/repository/injection_container.dart' as di;
import 'package:pino_de_henyo/views/dashboard_page.dart';
import 'package:pino_de_henyo/views/onboarding_page.dart';
import 'package:pino_de_henyo/views/signature.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.delayed(Duration(seconds: 1));
  FlutterNativeSplash.remove();

  api_helper.initializeClient(token: '');
  await di.init();
  var sharedPref = await SharedPreferences.getInstance();

  bool isStarted = await sharedPref.getBool('doneOnboarding') ?? false;
  double pinoVolume = sharedPref.getDouble('PinoVolume') ?? 1;

  FlutterTts flutterTts = FlutterTts();
  await flutterTts.setVoice({"name": "fil-ph-x-fic-local", "locale": "fil-PH"});
  await flutterTts.setSpeechRate(0.5);
  await flutterTts.setVolume(pinoVolume);
  await flutterTts.setPitch(.6);

  runApp(MyApp(isStarted: isStarted));
}

class MyApp extends StatelessWidget {
  final bool isStarted;
  const MyApp({super.key, required this.isStarted});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pino De Henyo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: isStarted ? DashboardPage() : OnboardingPage(),
      // home: Signature(),
    );
  }
}
