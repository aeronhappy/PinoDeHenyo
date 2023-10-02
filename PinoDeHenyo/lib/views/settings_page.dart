import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/widgets/others/bg_music.dart';
import 'package:pino_de_henyo/widgets/others/tts_voice_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double musicValue = 1;
  double effectsValue = 1;
  double pinoValue = 1;
  int bgIndex = 0;

  getSounds() async {
    var share = await SharedPreferences.getInstance();
    setState(() {
      bgIndex = share.getInt('Music') ?? 0;
      musicValue = share.getDouble('MusicVolume') ?? 1;
      effectsValue = share.getDouble('EffectsVolume') ?? 1;
      pinoValue = share.getDouble('PinoVolume') ?? 1;
    });
  }

  @override
  void initState() {
    super.initState();
    getSounds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightPrimarybgColor,
        appBar: AppBar(
            title: Text('SETTINGS', style: titleMediumLight),
            backgroundColor: lightPrimarybgColor,
            iconTheme: Theme.of(context).iconTheme,
            elevation: 0),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Background', style: titleMediumLight),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .55,
                    child: Slider(
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
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Effects', style: titleMediumLight),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .55,
                    child: Slider(
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
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pino Volume', style: titleMediumLight),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .55,
                    child: Slider(
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
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Background Music',
                style: titleMediumLight,
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: ListView.builder(
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
                                    style: titleSmallLight,
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
        ));
  }
}
