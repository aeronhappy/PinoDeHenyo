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

class QuizPage extends StatefulWidget {
  final String title;
  const QuizPage({super.key, required this.title});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  PageController pageController = PageController();

  bool equalsIgnoreCase(String? string1, String? string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

  String changeString(String original, String needToChange) {
    String newString = original.replaceAll(needToChange, '_______');
    return newString;
  }

  String changeStringforPino(String original, String needToChange) {
    String newString = original.replaceAll(needToChange, 'blank.');
    return newString;
  }

  int selectedAnswer = 5;

  @override
  void initState() {
    super.initState();

    context.read<QuestionControllerBloc>().add(GetQuizLevel());
    context.read<QuestionControllerBloc>().add(GetQuizQuestion());
  }

  int mylevel = 0;
  int level = 0;
  String myAnswer = '';
  List<LessonCategoryModel> newQuestion = [];
  List<String> choices = [];
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
            if (state is LoadedQuizQuestion) {
              setState(() {
                newQuestion = state.lessonList;
              });
            }
            if (state is LoadedQuizChoices) {
              setState(() {
                choices = state.choices;
              });
            }
            if (state is LoadedQuizLevel) {
              setState(() {
                mylevel = state.myLevel;
                level = state.myLevel;
              });
              pageController.jumpToPage(state.myLevel);
            }
            if (state is LoadedQuizSelected) {
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
              setState(() {
                selectedAnswer = 5;
              });
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
                                        levelDialog(
                                            context, mylevel, 'MAGSAGOT');
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(50)),
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
                                          .add(SaveQuizLevel(level: index));
                                    }
                                    context.read<QuestionControllerBloc>().add(
                                        GetQuizChoices(
                                            answer: newQuestion[index].title));
                                  },
                                  itemCount: newQuestion.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(15),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .7,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              child: Image.asset(
                                                newQuestion[index].image,
                                                fit: BoxFit.fitHeight,
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
                                        Text(
                                          changeString(
                                              newQuestion[index].description,
                                              newQuestion[index]
                                                  .title
                                                  .toLowerCase()),
                                          style:
                                              googleFonts(16, Colors.black54),
                                        ),
                                        SizedBox(height: 20),
                                        Expanded(
                                            child: GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent: 180,
                                                        childAspectRatio: 2.5,
                                                        crossAxisSpacing: 10,
                                                        mainAxisSpacing: 10),
                                                itemCount: choices.length,
                                                itemBuilder:
                                                    (BuildContext ctx, index) {
                                                  return InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      onTap: () {
                                                        setState(() {
                                                          myAnswer =
                                                              choices[index];
                                                          selectedAnswer =
                                                              index;
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Material(
                                                          elevation: 10,
                                                          shape:
                                                              StadiumBorder(),
                                                          child: Container(
                                                              decoration: ShapeDecoration(
                                                                  color: selectedAnswer == index
                                                                      ? Colors
                                                                          .amber
                                                                          .shade900
                                                                      : lightSecondarybgColor,
                                                                  shape:
                                                                      StadiumBorder()),
                                                              child: Center(
                                                                  child: Text(
                                                                      choices[
                                                                          index],
                                                                      style: googleFonts(
                                                                          selectedAnswer == index
                                                                              ? 22
                                                                              : 18,
                                                                          Colors
                                                                              .black)))),
                                                        ),
                                                      ));
                                                })),
                                        const SizedBox(height: 10),
                                        InkWell(
                                          onTap: selectedAnswer == 5
                                              ? null
                                              : () {
                                                  if (equalsIgnoreCase(
                                                      myAnswer,
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
                                                            isCorrect: false));
                                                  }
                                                },
                                          child: Opacity(
                                            opacity:
                                                selectedAnswer == 5 ? .4 : 1,
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
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                            )
                          ])))))
    ]);
  }
}
