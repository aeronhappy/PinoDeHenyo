import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/lesson_category_model.dart';
import 'package:pino_de_henyo/widgets/alert_dialog/correct_answer_popup.dart';
import 'package:pino_de_henyo/widgets/alert_dialog/level_pop_up.dart';
import 'package:pino_de_henyo/widgets/alert_dialog/wrong_answer_popup.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';
import 'package:pino_de_henyo/widgets/music.dart';

class WritingPage extends StatefulWidget {
  final String title;
  const WritingPage({super.key, required this.title});

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  TextEditingController textEditingController = TextEditingController();
  PageController pageController = PageController();

  bool equalsIgnoreCase(String? string1, String? string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

  // final control = HandSignatureControl(
  //   threshold: 3.0,
  //   smoothRatio: 0.65,
  //   velocityRange: 2.0,
  // );

  int mylevel = 0;
  int level = 0;
  List<LessonCategoryModel> newQuestion = [];

  @override
  void initState() {
    super.initState();
    context.read<QuestionControllerBloc>().add(GetWritingLevel());
    context.read<QuestionControllerBloc>().add(GetWritingShuffleQuestion());
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
              if (state is LoadedWritingQuestion) {
                setState(() {
                  newQuestion = state.lessonList;
                });
              }
              if (state is LoadedWritingLevel) {
                setState(() {
                  mylevel = state.myLevel;
                  level = state.myLevel;
                });
                pageController.jumpToPage(state.myLevel);
              }
              if (state is LoadedWritingSelected) {
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
                                  levelDialog(context, mylevel, 'MAGSULAT');
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
                              if (mylevel < index) {
                                context
                                    .read<QuestionControllerBloc>()
                                    .add(SaveWritingLevel(level: index));
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
                                                    BorderRadius.circular(40)),
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
                                                  child: const Icon(
                                                      Icons.volume_up_rounded),
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
                                            itemCount:
                                                newQuestion[index].title.length,
                                            itemBuilder:
                                                (context, stringIndex) {
                                              return Container(
                                                width: 38,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2.5),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Center(
                                                    child: Text(
                                                  newQuestion[index]
                                                      .title[stringIndex]
                                                      .toUpperCase(),
                                                  style: smallTitleWhite(true)
                                                      .copyWith(
                                                    fontSize: 22,
                                                    color: Colors.accents[
                                                        Random().nextInt(Colors
                                                            .accents.length)],
                                                  ),
                                                )),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  // Container(
                                  //   height: MediaQuery.of(context).size.height * .2,
                                  //   color: Colors.white30,
                                  //   child: HandSignature(
                                  //     control: control,
                                  //     type: SignatureDrawType.arc,
                                  //   ),
                                  // ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    controller: textEditingController,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (equalsIgnoreCase(
                                          textEditingController.text,
                                          newQuestion[index].title)) {
                                        context
                                            .read<QuestionControllerBloc>()
                                            .add(ClickSubmit(isCorrect: true));
                                      } else {
                                        context
                                            .read<QuestionControllerBloc>()
                                            .add(ClickSubmit(isCorrect: false));
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: ShapeDecoration(
                                          shape: const StadiumBorder(),
                                          color: Colors.blue),
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      )),
                                    ),
                                  )
                                ],
                              );
                            }),
                      )
                    ]),
              ),
            )))
      ],
    );
  }
}
