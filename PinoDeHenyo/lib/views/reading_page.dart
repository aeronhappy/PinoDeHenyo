import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/lesson_category_model.dart';
import 'package:pino_de_henyo/widgets/alert_dialog/correct_answer_popup.dart';
import 'package:pino_de_henyo/widgets/alert_dialog/level_pop_up.dart';
import 'package:pino_de_henyo/widgets/alert_dialog/wrong_answer_popup.dart';
import 'package:pino_de_henyo/widgets/music.dart';

import 'package:speech_to_text/speech_to_text.dart';

class ReadingPage extends StatefulWidget {
  final String title;
  const ReadingPage({super.key, required this.title});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  SpeechToText speechToText = SpeechToText();
  PageController pageController = PageController();

  bool isListening = false;
  String answerText = '--';
  int mylevel = 0;
  int level = 0;
  List<LessonCategoryModel> newQuestion = [];

  bool equalsIgnoreCase(String? string1, String? string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

  @override
  void initState() {
    super.initState();
    context.read<QuestionControllerBloc>().add(GetReadingLevel());
    context.read<QuestionControllerBloc>().add(GetReadingShuffleQuestion());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionControllerBloc, QuestionControllerState>(
      listener: (context, state) {
        if (state is LoadedReadingQuestion) {
          setState(() {
            newQuestion = state.lessonList;
          });
        }
        if (state is LoadedReadingLevel) {
          setState(() {
            mylevel = state.myLevel;
            level = state.myLevel;
          });
          pageController.jumpToPage(state.myLevel);
        }
        if (state is LoadedReadingSelected) {
          setState(() {
            level = state.level;
          });
          pageController.jumpToPage(state.level);
        }
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
            title: Text('MAGBASA', style: appBarBlack(true)),
            backgroundColor: lightPrimarybgColor,
            iconTheme: Theme.of(context).iconTheme,
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                    onTap: () {
                      levelDialog(context, mylevel, 'MAGBASA');
                    },
                    child: Material(
                      shape: StadiumBorder(),
                      elevation: 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: ShapeDecoration(
                            color: Colors.brown, shape: StadiumBorder()),
                        child: Center(
                          child: Text(
                            'Level ${level + 1}',
                            style: largeTitleWhite(true),
                          ),
                        ),
                      ),
                    )),
              )
            ],
          ),
          body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (index) {
                if (mylevel < index) {
                  context
                      .read<QuestionControllerBloc>()
                      .add(SaveReadingLevel(level: index));
                }
              },
              itemCount: newQuestion.length,
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
                                  newQuestion[index].image,
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
                                        textToSpeech(newQuestion[index].title);
                                      },
                                      elevation: 5,
                                      backgroundColor: green,
                                      splashColor: green,
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
                                itemCount: newQuestion[index].title.length,
                                itemBuilder: (context, stringIndex) {
                                  return Container(
                                    width: 40,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2.5),
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: Center(
                                        child: Text(
                                      newQuestion[index]
                                          .title[stringIndex]
                                          .toUpperCase(),
                                      style: largeTitleWhite(true),
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
                                      style: largeTitleBlack(true),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  if (equalsIgnoreCase(
                                      answerText, newQuestion[index].title)) {
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
                            splashColor: red.withOpacity(.6),
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
                                backgroundColor: red,
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
