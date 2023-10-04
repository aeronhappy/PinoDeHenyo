import 'package:flutter/material.dart';
import 'package:pino_de_henyo/views/text_scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TextScanner()));
          },
          child: const Text('Open Camera to scan'),
        ),
      ),
    );
  }
}
