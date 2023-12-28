import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/lesson_category_model.dart';
import 'package:pino_de_henyo/widgets/correct_answer_popup.dart';
import 'package:pino_de_henyo/widgets/level_pop_up.dart';
import 'package:pino_de_henyo/widgets/wrong_answer_popup.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';
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
  String answerText = '';
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
        BlocListener<QuestionControllerBloc, QuestionControllerState>(
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
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
              setState(() {
                answerText = '--';
              });
            }
          },
          child: SafeArea(
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBackButton(text: widget.title),
                          Material(
                            shape: StadiumBorder(),
                            elevation: 3,
                            color: Colors.grey.shade600,
                            child: InkWell(
                                borderRadius: BorderRadius.circular(100),
                                highlightColor: red,
                                onTap: () {
                                  levelDialog(context, mylevel, 'MAGBASA');
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: Text(
                                      'Level ${level + 1}',
                                      style: smallTitleWhite(true)
                                          .copyWith(fontSize: 18),
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Expanded(
                          child: PageView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  level = index;
                                });
                                if (mylevel < index) {
                                  context
                                      .read<QuestionControllerBloc>()
                                      .add(SaveReadingLevel(level: index));
                                }
                              },
                              itemCount: newQuestion.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .9,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
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
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: FloatingActionButton(
                                                    onPressed: () {
                                                      textToSpeech(
                                                          newQuestion[index]
                                                              .title);
                                                    },
                                                    elevation: 5,
                                                    backgroundColor: green,
                                                    splashColor: green,
                                                    child: const Icon(Icons
                                                        .volume_up_rounded),
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
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: newQuestion[index]
                                                  .title
                                                  .length,
                                              itemBuilder:
                                                  (context, stringIndex) {
                                                return Container(
                                                  width: 38,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 2.5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                      child: Text(
                                                    newQuestion[index]
                                                        .title[stringIndex]
                                                        .toUpperCase(),
                                                    style: smallTitleWhite(true)
                                                        .copyWith(
                                                      fontSize: 22,
                                                      color: Colors.accents[
                                                          Random().nextInt(
                                                              Colors.accents
                                                                  .length)],
                                                    ),
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
                                        Container(
                                          height: 55,
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color:
                                                  Colors.white.withOpacity(.6)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(width: 45),
                                              Center(
                                                child: Text(
                                                  answerText.isEmpty
                                                      ? "talk and your answer will appear here!"
                                                      : answerText,
                                                  style: answerText.isEmpty
                                                      ? bodyBlack.copyWith(
                                                          fontSize: 14)
                                                      : bodyBlack.copyWith(
                                                          color: Colors.black,
                                                          fontSize: 20),
                                                ),
                                              ),
                                              Material(
                                                color:
                                                    Colors.blue.withOpacity(.8),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                elevation: 0,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  splashColor: Colors.blue,
                                                  onTap: () {
                                                    if (equalsIgnoreCase(
                                                        answerText,
                                                        newQuestion[index]
                                                            .title)) {
                                                      context
                                                          .read<
                                                              QuestionControllerBloc>()
                                                          .add(ClickSubmit(
                                                              isCorrect: true));
                                                    } else {
                                                      context
                                                          .read<
                                                              QuestionControllerBloc>()
                                                          .add(ClickSubmit(
                                                              isCorrect:
                                                                  false));
                                                    }
                                                  },
                                                  child: SizedBox(
                                                    height: 45,
                                                    width: 45,
                                                    child: const Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        InkWell(
                                          splashColor: red.withOpacity(.6),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          onTapDown: (details) async {
                                            if (!isListening) {
                                              var available = await speechToText
                                                  .initialize();
                                              if (available) {
                                                setState(() {
                                                  isListening = true;
                                                  speechToText.listen(
                                                      onResult: (result) {
                                                    setState(() {
                                                      answerText = result
                                                          .recognizedWords;
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
                                                isListening
                                                    ? Icons.mic
                                                    : Icons.mic_none,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              }))
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
