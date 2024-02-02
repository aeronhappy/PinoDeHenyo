import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/lesson_category_model.dart';
import 'package:pino_de_henyo/widgets/music.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LessonInfoPage extends StatefulWidget {
  final LessonCategoryModel item;
  const LessonInfoPage({super.key, required this.item});

  @override
  State<LessonInfoPage> createState() => _LessonInfoPageState();
}

class _LessonInfoPageState extends State<LessonInfoPage> {
  bool isPinoReading = false;
  textToSpeechWithPino(String text) async {
    setState(() {
      isPinoReading = true;
    });
    var sharedPref = await SharedPreferences.getInstance();
    var pinoValue = sharedPref.getDouble('PinoVolume') ?? .5;
    var bgIndex = sharedPref.getInt('Music') ?? 0;

    await bgAudioPlayer.loop(bgList[bgIndex], volume: .05);
    await flutterTts
        .setVoice({"name": "fil-ph-x-fid-local", "locale": "fil-PH"});
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(pinoValue);
    await flutterTts.setPitch(1.5);
    await flutterTts.speak(text);

    await flutterTts.awaitSpeakCompletion(true).whenComplete(() {
      playMusic();
      setState(() {
        isPinoReading = false;
      });
    });
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
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Material(
                        elevation: 5,
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20)),
                        child: Container(
                          height: 350,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: widget.item.color,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(20))),
                          child: Center(
                            child: Hero(
                                tag: '${widget.item.image}-tags',
                                child: Image.asset(widget.item.image)),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(5),
                            child: FloatingActionButton(
                              onPressed: isPinoReading
                                  ? null
                                  : () {
                                      textToSpeechWithPino(
                                          "${widget.item.title} \n ${widget.item.description} \n halimbawa. ${widget.item.example}");
                                    },
                              elevation: 5,
                              backgroundColor: green,
                              splashColor: green,
                              child: const Icon(Icons.volume_up_rounded),
                            ),
                          )),
                      Positioned(
                          top: 30,
                          left: 10,
                          child: InkWell(
                            onTap: () {
                              flutterTts.stop();
                              Feedback.forTap(context);
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.transparent,
                              child: Icon(Icons.arrow_back_rounded,
                                  size: 50, color: Colors.white),
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Text(widget.item.title,
                              style: largeTitleBlack(true)
                                  .copyWith(color: widget.item.color)),
                        ),
                        SizedBox(height: 30),
                        Text('Description', style: smallTitleBlack(false)),
                        SizedBox(height: 10),
                        Text(widget.item.description, style: bodyBlack),
                        SizedBox(height: 30),
                        Text('Example', style: smallTitleBlack(false)),
                        SizedBox(height: 10),
                        Text(widget.item.example, style: bodyBlack),
                      ],
                    ),
                  )
                ]),
          ),
        ),
        AnimatedPositioned(
            duration: Duration(milliseconds: 100),
            right: -50,
            bottom: isPinoReading ? -10 : -250,
            child: Container(
              height: 250,
              width: 250,
              child: Image.asset(
                "assets/pino/pino_medium.png",
              ),
            )),
      ],
    );
  }
}
