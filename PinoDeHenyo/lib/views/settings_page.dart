import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';
import 'package:pino_de_henyo/widgets/music.dart';
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
      musicValue = share.getDouble('MusicVolume') ?? .25;
      effectsValue = share.getDouble('EffectsVolume') ?? .25;
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text('Music Volume', style: largeTitleWhite(true)),
                    SizedBox(height: 5),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: Colors.black38,
                          activeTrackColor: Colors.red,
                          thumbColor: red,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 13),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 10),
                          trackHeight: 13,
                          trackShape: RoundedRectSliderTrackShape()),
                      child: Slider(
                        value: musicValue,
                        max: 1,
                        onChangeEnd: (value) {
                          playMusic();
                        },
                        onChanged: (value) async {
                          setState(() {
                            musicValue = value;
                          });
                          var sharedPref =
                              await SharedPreferences.getInstance();
                          await sharedPref.setDouble('MusicVolume', value);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Column(
                  children: [
                    Text('Sound Effects', style: largeTitleWhite(true)),
                    SizedBox(height: 5),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: Colors.black38,
                          activeTrackColor: Colors.red,
                          thumbColor: red,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 13),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 10),
                          trackHeight: 13,
                          trackShape: RoundedRectSliderTrackShape()),
                      child: Slider(
                        value: effectsValue,
                        max: 1,
                        onChangeEnd: (value) async {
                          effectsAudioPlayer.play('bg_music/testing_bg.mp3',
                              volume: value);
                          var sharedPref =
                              await SharedPreferences.getInstance();
                          await sharedPref.setDouble('EffectsVolume', value);
                        },
                        onChanged: (value) {
                          setState(() {
                            effectsValue = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Column(
                  children: [
                    Text('Pino Volume', style: largeTitleWhite(true)),
                    SizedBox(height: 5),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: Colors.black38,
                          activeTrackColor: Colors.red,
                          thumbColor: red,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 13),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 10),
                          trackHeight: 13,
                          trackShape: RoundedRectSliderTrackShape()),
                      child: Slider(
                        value: pinoValue,
                        onChangeEnd: (value) async {
                          var sharedPref =
                              await SharedPreferences.getInstance();
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
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Column(
                  children: [
                    Text('Background Music', style: largeTitleWhite(true)),
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: bgList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(100),
                              highlightColor: Colors.red,
                              onTap: () async {
                                setState(() {
                                  bgIndex = index;
                                });
                                var sharedPref =
                                    await SharedPreferences.getInstance();
                                await sharedPref.setInt('Music', index);
                                playMusic();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Material(
                                  borderRadius: BorderRadius.circular(100),
                                  elevation: 5,
                                  color: Colors.transparent,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .28,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: index == bgIndex
                                            ? Colors.red
                                            : lightPrimarybgColor,
                                        border: Border.all(width: 2),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                        child: Text(
                                      "Music ${index + 1}",
                                      style: index == bgIndex
                                          ? bodyWhite.copyWith(
                                              color: Colors.white)
                                          : bodyBlack.copyWith(
                                              color: Colors.black),
                                    )),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        CustomBackButton(text: 'Settings'),
      ],
    );
  }
}
