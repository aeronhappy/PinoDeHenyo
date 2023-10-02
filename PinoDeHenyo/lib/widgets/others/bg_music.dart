import 'package:audioplayers/audioplayers.dart';

var audioP = AudioPlayer();
var bgAudioPlayer = AudioCache(fixedPlayer: audioP);
var effectsAudioPlayer = AudioCache();

List<String> bgList = <String>[
  'bg_music/bg_1.mp3',
  'bg_music/bg_2.mp3',
  'bg_music/bg_3.mp3'
];

playMusic(int bgIndex, double volume) {
  bgAudioPlayer.loop(bgList[bgIndex], volume: volume);
}

stopMusic() {
  audioP.stop();
}
