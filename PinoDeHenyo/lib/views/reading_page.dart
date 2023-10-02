import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/lesson_model.dart';
import 'package:pino_de_henyo/widgets/alert_dialog/correct_answer_popup.dart';
import 'package:pino_de_henyo/widgets/alert_dialog/wrong_answer_popup.dart';
import 'package:pino_de_henyo/widgets/others/tts_voice_settings.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage({super.key});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  SpeechToText speechToText = SpeechToText();
  PageController pageController = PageController();

  bool isListening = false;
  String answerText = '--';

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
          setState(() {
            answerText = '--';
          });
        }
      },
      child: Scaffold(
          backgroundColor: lightPrimarybgColor,
          appBar: AppBar(
            title: Text('MAGBASA', style: titleMediumLight),
            backgroundColor: lightPrimarybgColor,
            iconTheme: Theme.of(context).iconTheme,
            elevation: 0,
          ),
          body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              itemCount: lessonList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                height: MediaQuery.of(context).size.width * .9,
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
                                        textToSpeech(lessonList[index].title);
                                      },
                                      elevation: 5,
                                      backgroundColor: successColor,
                                      splashColor: successColor,
                                      child:
                                          const Icon(Icons.volume_up_rounded),
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              child: ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: lessonList[index].title.length,
                                itemBuilder: (context, stringIndex) {
                                  return Container(
                                    width: 40,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2.5),
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: Center(
                                        child: Text(
                                      lessonList[index]
                                          .title[stringIndex]
                                          .toUpperCase(),
                                      style: titleLargeLight,
                                    )),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all()),
                                  child: Center(
                                    child: Text(
                                      answerText,
                                      style: bodyLargeLight,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  if (equalsIgnoreCase(
                                      answerText, lessonList[index].title)) {
                                    context
                                        .read<QuestionControllerBloc>()
                                        .add(ClickSubmit(isCorrect: true));
                                  } else {
                                    context
                                        .read<QuestionControllerBloc>()
                                        .add(ClickSubmit(isCorrect: false));
                                  }
                                },
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                      padding: const EdgeInsets.all(13),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.blue),
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      )),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          InkWell(
                            splashColor: errorColor.withOpacity(.6),
                            borderRadius: BorderRadius.circular(100),
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
                            child: Padding(
                              padding: const EdgeInsets.all(20),
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
                    ],
                  ),
                );
              })),
    );
  }
}
