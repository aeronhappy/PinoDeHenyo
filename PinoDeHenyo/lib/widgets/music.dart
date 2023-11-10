import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

FlutterTts flutterTts = FlutterTts();

List<String> bgList = <String>[
  'bg_music/bg_1.mp3',
];

// textToSpeech(String text, VoidCallback? whenComplete) async {
//   await flutterTts.setVoice({"name": "fil-ph-x-cfc-local", "locale": "fil-PH"});
//   await flutterTts.setSpeechRate(.5);
//   await flutterTts.setPitch(1.5);
//   await flutterTts.speak(text);
//   await flutterTts.awaitSpeakCompletion(true).whenComplete(whenComplete!);
// }

textToSpeech(String text, VoidCallback? whenComplete) async {
  await flutterTts.setVoice({"name": "fil-ph-x-cfc-local", "locale": "fil-PH"});
  await flutterTts.setSpeechRate(0.9);
  await flutterTts.setVolume(1);
  await flutterTts.setPitch(.4);
  await flutterTts.speak(text);
  await flutterTts.awaitSpeakCompletion(true).whenComplete(whenComplete!);
}
