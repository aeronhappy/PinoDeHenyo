import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/lesson_model.dart';
import 'package:pino_de_henyo/widgets/others/tts_voice_settings.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightPrimarybgColor,
        appBar: AppBar(
          title: Text('MAG-ARAL', style: titleMediumLight),
          backgroundColor: lightPrimarybgColor,
          iconTheme: Theme.of(context).iconTheme,
          elevation: 0,
        ),
        body: ListView.builder(
          itemCount: lessonList.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: Material(
                elevation: 2,
                child: Container(
                  color: lightSecondarybgColor,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.width * .7,
                              width: double.infinity,
                              decoration: BoxDecoration(border: Border.all()),
                              child: Image.asset(
                                lessonList[index].image,
                                fit: BoxFit.fill,
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
                                    onPressed: () {
                                      textToSpeech(
                                          '${lessonList[index].title}, ${lessonList[index].description} ');
                                    },
                                    elevation: 5,
                                    backgroundColor: successColor,
                                    splashColor: successColor,
                                    child: const Icon(Icons.volume_up_rounded),
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          lessonList[index].title,
                          style: GoogleFonts.titanOne(
                            fontSize: 22.5,
                            decoration: TextDecoration.none,
                            color: Colors.brown,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kahulugan :',
                                style: bodySmallLight,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(lessonList[index].description,
                                    style: titleSmallLight),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Halimbawa :',
                                style: bodySmallLight,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(lessonList[index].example,
                                    style: titleSmallLight),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ]),
                ),
              ),
            );
          }),
        ));
  }
}
