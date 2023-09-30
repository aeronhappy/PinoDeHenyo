import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage({super.key});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  FlutterTts flutterTts = FlutterTts();
  TextEditingController textEditingController = TextEditingController();

  textToSpeech(String text) async {
    await flutterTts.speak('HOOOOOOOOOOy');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('PinoDeHenyo', style: Theme.of(context).textTheme.titleMedium),
      ),
      body: Column(
        children: [
          TextField(
            controller: textEditingController,
          ),
          InkWell(
            onTap: () {
              textToSpeech(textEditingController.text);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.volume_up_rounded),
            ),
          )
        ],
      ),
    );
  }
}
