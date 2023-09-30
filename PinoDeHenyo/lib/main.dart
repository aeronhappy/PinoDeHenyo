import 'package:flutter/material.dart';
import 'package:youtube_app/helper/api_helper.dart' as api_helper;
import 'package:youtube_app/repository/injection_container.dart' as di;
import 'package:youtube_app/views/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  api_helper.initializeClient(token: '');
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const OnBoardingPage(),
    );
  }
}
