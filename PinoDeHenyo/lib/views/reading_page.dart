import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/question_model.dart';
import 'package:pino_de_henyo/widgets/alert_dialog/correct_answer_popup.dart';
import 'package:pino_de_henyo/widgets/alert_dialog/wrong_answer_popup.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage({super.key});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  FlutterTts flutterTts = FlutterTts();
  TextEditingController textEditingController = TextEditingController();
  SpeechToText speechToText = SpeechToText();
  PageController pageController = PageController();

  bool isListening = false;
  String answerText = '';

  textToSpeech(String text) async {
    await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1);
    await flutterTts.setPitch(0.5);
    await flutterTts.speak(text);
  }

  bool equalsIgnoreCase(String? string1, String? string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionControllerBloc, QuestionControllerState>(
      listener: (context, state) {
        if (state is CorrectAnswer) {
          correctAnswerDialog(context);
        }
        if (state is WrongAnswer) {
          wrongAnswerDialog(context);
        }
        if (state is NextQuestion) {
          pageController.nextPage(
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        }
      },
      child: Scaffold(
          backgroundColor: lightPrimarybgColor,
          appBar: AppBar(
            title: Text('Reading', style: titleMediumLight),
            backgroundColor: lightPrimarybgColor,
            iconTheme: Theme.of(context).iconTheme,
            elevation: 0,
          ),
          body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.width * .7,
                            width: double.infinity,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Image.network(
                              questions[index].image,
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
                                    textToSpeech(questions[index].text);
                                  },
                                  elevation: 5,
                                  backgroundColor: successColor,
                                  splashColor: successColor,
                                  child: const Icon(Icons.volume_up_rounded),
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: questions[index].text.length,
                            itemBuilder: (context, stringIndex) {
                              return Container(
                                width: 40,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2.5),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Center(
                                    child: Text(
                                  questions[index].text[stringIndex],
                                  style: titleLargeLight,
                                )),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      AvatarGlow(
                        endRadius: 75,
                        animate: isListening,
                        duration: const Duration(microseconds: 1000),
                        glowColor: errorColor,
                        repeat: true,
                        repeatPauseDuration: const Duration(microseconds: 1000),
                        showTwoGlows: true,
                        child: GestureDetector(
                          onTapDown: (details) async {
                            if (!isListening) {
                              var available = await speechToText.initialize();
                              if (available) {
                                setState(() {
                                  isListening = true;
                                  speechToText.listen(onResult: (result) {
                                    setState(() {
                                      answerText = result.recognizedWords;
                                    });
                                  });
                                });
                              }
                            }
                          },
                          onTapUp: (details) {
                            setState(() {
                              isListening = false;
                            });
                            speechToText.stop();
                          },
                          child: CircleAvatar(
                            backgroundColor: errorColor,
                            radius: 35,
                            child: Icon(
                              isListening ? Icons.mic : Icons.mic_none,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
