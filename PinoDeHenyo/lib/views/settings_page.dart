import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';
import 'package:pino_de_henyo/widgets/others/bg_music.dart';
import 'package:pino_de_henyo/widgets/others/tts_voice_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double musicValue = .5;
  double effectsValue = .5;
  double pinoValue = .5;
  int bgIndex = 0;

  getSounds() async {
    var share = await SharedPreferences.getInstance();
    setState(() {
      bgIndex = share.getInt('Music') ?? 0;
      musicValue = share.getDouble('MusicVolume') ?? .5;
      effectsValue = share.getDouble('EffectsVolume') ?? .5;
      pinoValue = share.getDouble('PinoVolume') ?? .5;
    });
  }

  @override
  void initState() {
    super.initState();
    getSounds();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 0,
          child: Image.asset(
            'assets/pino/sky_bg.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * .15, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Slider(
                  value: (musicValue),
                  onChangeEnd: (value) async {
                    playMusic(bgIndex, value);
                    var sharedPref = await SharedPreferences.getInstance();
                    await sharedPref.setDouble('MusicVolume', value);
                  },
                  onChanged: (value) {
                    setState(() {
                      musicValue = value;
                    });
                  },
                ),
                Text('Music Volume',
                    style: smallTitleWhite.copyWith(
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2.0,
                          color: Colors.black,
                        ),
                      ],
                    )),
                SizedBox(height: 50),
                Slider(
                  value: (effectsValue),
                  onChangeEnd: (value) async {
                    effectsAudioPlayer.play('bg_music/testing_bg.mp3',
                        volume: value);
                    var sharedPref = await SharedPreferences.getInstance();
                    await sharedPref.setDouble('EffectsVolume', value);
                  },
                  onChanged: (value) {
                    setState(() {
                      effectsValue = value;
                    });
                  },
                ),
                Text('Sound Effects',
                    style: smallTitleWhite.copyWith(
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2.0,
                          color: Colors.black,
                        ),
                      ],
                    )),
                SizedBox(height: 50),
                Slider(
                  value: (pinoValue),
                  onChangeEnd: (value) async {
                    var sharedPref = await SharedPreferences.getInstance();
                    await sharedPref.setDouble('PinoVolume', value);
                    await flutterTts.setVolume(value);
                    await flutterTts.speak('Ako si Pino');
                  },
                  onChanged: (value) {
                    setState(() {
                      pinoValue = value;
                    });
                  },
                ),
                Text('Pino Volume',
                    style: smallTitleWhite.copyWith(
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2.0,
                          color: Colors.black,
                        ),
                      ],
                    )),
                SizedBox(height: 50),
                Text('Background Music',
                    style: smallTitleWhite.copyWith(
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2.0,
                          color: Colors.black,
                        ),
                      ],
                    )),
                Expanded(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: bgList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () async {
                            setState(() {
                              bgIndex = index;
                            });
                            playMusic(index, musicValue);
                            var sharedPref =
                                await SharedPreferences.getInstance();
                            await sharedPref.setInt('Music', index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Material(
                              shape: StadiumBorder(),
                              elevation: 5,
                              child: Container(
                                height: 50,
                                decoration: ShapeDecoration(
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            width: 2, color: Colors.brown))),
                                child: Stack(
                                  children: [
                                    Center(
                                        child: Text(
                                      'Option ${index + 1}',
                                      style: titleBlack,
                                    )),
                                    index == bgIndex
                                        ? Positioned(
                                            right: 10,
                                            bottom: 0,
                                            top: 0,
                                            child: CircleAvatar(
                                              radius: 15,
                                              backgroundColor: Colors.red,
                                              child: Icon(
                                                Icons.music_note,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ))
                                        : Container()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomBackButton(
          text: 'Settings',
          tag: 'settings-tag',
        ),
      ],
    );
  }
}
