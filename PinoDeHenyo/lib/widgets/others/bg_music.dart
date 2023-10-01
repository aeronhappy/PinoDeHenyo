import 'package:audioplayers/audioplayers.dart';

AudioPlayer audioPlayer = AudioPlayer();
void playMusic() async {
  // final player = AudioCache(prefix: 'assets/bg_music');
  // final url = await player.load('kids_bg_1.mp3');
  // audioPlayer.setUrl(url.path, isLocal: true);
  String url =
      'https://www.youtube.com/watch?v=l2cPgDtBqD0&list=RDl2cPgDtBqD0&start_radio=1';
  audioPlayer.play(url);
}
