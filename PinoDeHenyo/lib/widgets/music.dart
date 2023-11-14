import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

FlutterTts flutterTts = FlutterTts();
var audioP = AudioPlayer();
var bgAudioPlayer = AudioCache(fixedPlayer: audioP);
var effectsAudioPlayer = AudioCache();

List<String> bgList = <String>[
  'bg_music/bg_1.mp3',
  'bg_music/bg_2.mp3',
  'bg_music/bg_3.mp3'
];

playMusic() async {
  var sharedPref = await SharedPreferences.getInstance();
  var bgIndex = sharedPref.getInt('Music') ?? 0;
  var musicValue = sharedPref.getDouble('MusicVolume') ?? .25;
  await bgAudioPlayer.loop(bgList[bgIndex], volume: musicValue);

  // var effectsValue = sharedPref.getDouble('EffectsVolume') ?? .25;
}

stopMusic() {
  audioP.stop();
}

textToSpeech(String text) async {
  var sharedPref = await SharedPreferences.getInstance();
  var pinoValue = sharedPref.getDouble('PinoVolume') ?? .5;
  var bgIndex = sharedPref.getInt('Music') ?? 0;

  await bgAudioPlayer.loop(bgList[bgIndex], volume: .05);
  await flutterTts.setVoice({"name": "fil-ph-x-fid-local", "locale": "fil-PH"});
  await flutterTts.setSpeechRate(0.5);
  await flutterTts.setVolume(pinoValue);
  await flutterTts.setPitch(1.5);
  await flutterTts.speak(text);

  await flutterTts.awaitSpeakCompletion(true).whenComplete(() {
    playMusic();
  });
}
