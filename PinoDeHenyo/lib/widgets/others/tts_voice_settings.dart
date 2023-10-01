import 'package:flutter_tts/flutter_tts.dart';

FlutterTts flutterTts = FlutterTts();

textToSpeech(String text) async {
  await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
  await flutterTts.setSpeechRate(0.5);
  await flutterTts.setVolume(1);
  await flutterTts.setPitch(0.5);
  await flutterTts.speak(text);
}
