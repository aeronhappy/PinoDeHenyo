import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/lesson_category_model.dart';
import 'package:pino_de_henyo/widgets/correct_answer_popup.dart';
import 'package:pino_de_henyo/widgets/level_pop_up.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';
import 'package:pino_de_henyo/widgets/music.dart';
import 'package:pino_de_henyo/widgets/string_translator.dart';
import 'package:pino_de_henyo/widgets/wrong_answer_popup.dart';

class WritingPage extends StatefulWidget {
  final String title;
  const WritingPage({super.key, required this.title});

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  PageController pageController = PageController();

  bool equalsIgnoreCase(String? string1, String? string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

  int mylevel = 0;
  int level = 0;
  String jumbleLetter = "";
  List<LessonCategoryModel> newQuestion = [];
  List<int> selectedIndex = [];
  String myAnswer = "";

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
                  jumbleLetter = getRandomString(12, newQuestion[0].title);
                });
              }
              if (state is LoadedWritingLevel) {
                setState(() {
                  mylevel = state.myLevel;
                  level = state.myLevel;
                  jumbleLetter = getRandomString(12, newQuestion[level].title);
                });
                pageController.jumpToPage(state.myLevel);
              }
              if (state is LoadedWritingSelected) {
                setState(() {
                  level = state.level;
                  jumbleLetter = getRandomString(12, newQuestion[level].title);
                });
                pageController.jumpToPage(state.level);
              }
              if (state is CorrectAnswer) {
                correctAnswerDialog(context);
              }
              if (state is WrongAnswer) {
                wrongAnswerDialog(context);
                setState(() {
                  selectedIndex.clear();
                  myAnswer = "";
                });
              }
              if (state is NextQuestion) {
                setState(() {
                  selectedIndex.clear();
                  myAnswer = "";
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              setState(() {
                                jumbleLetter = getRandomString(
                                    12, newQuestion[index].title);
                                level = index;
                              });
                              if (mylevel < index) {
                                context
                                    .read<QuestionControllerBloc>()
                                    .add(SaveWritingLevel(level: index));
                              }
                            },
                            itemCount: newQuestion.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        height:
                                            MediaQuery.of(context).size.width *
                                                .7,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(.5),
                                            borderRadius:
                                                BorderRadius.circular(40)),
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
                                            padding: const EdgeInsets.all(5),
                                            child: FloatingActionButton(
                                              onPressed: () {
                                                textToSpeech(
                                                    changeStringforPino(
                                                        newQuestion[index]
                                                            .description,
                                                        newQuestion[index]
                                                            .title
                                                            .toLowerCase()));
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
                                  Text(
                                    changeString(newQuestion[index].description,
                                        newQuestion[index].title.toLowerCase()),
                                    style: googleFonts(16, Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 110,
                                    width: double.infinity,
                                    child: GridView.builder(
                                        primary: false,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 50,
                                                childAspectRatio: 1.1,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                        itemCount: 12,
                                        itemBuilder:
                                            (BuildContext ctx, stringIndex) {
                                          return InkWell(
                                            onTap: selectedIndex
                                                    .contains(stringIndex)
                                                ? null
                                                : () {
                                                    setState(() {
                                                      myAnswer =
                                                          "${myAnswer + jumbleLetter[stringIndex]}";
                                                      selectedIndex
                                                          .add(stringIndex);
                                                    });
                                                  },
                                            child: AnimatedOpacity(
                                              opacity: selectedIndex
                                                      .contains(stringIndex)
                                                  ? 0
                                                  : 1,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2),
                                                decoration: BoxDecoration(
                                                    color: Colors
                                                        .accents[stringIndex]
                                                        .shade700,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Center(
                                                    child: Text(
                                                  jumbleLetter[stringIndex]
                                                      .toUpperCase(),
                                                  style: smallTitleWhite(true)
                                                      .copyWith(fontSize: 20),
                                                )),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  child: Center(
                                                    child: Container(
                                                      height: 35,
                                                      alignment:
                                                          Alignment.center,
                                                      child: ListView.builder(
                                                        physics:
                                                            const ClampingScrollPhysics(),
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            myAnswer.length,
                                                        itemBuilder: (context,
                                                            stringIndex) {
                                                          return Container(
                                                            width: 30,
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        1.5),
                                                            child: Center(
                                                                child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                  myAnswer[
                                                                          stringIndex]
                                                                      .toUpperCase(),
                                                                  style: smallTitleBlack(
                                                                          false)
                                                                      .copyWith(
                                                                          fontSize:
                                                                              18),
                                                                ),
                                                                Container(
                                                                  height: 2,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black,
                                                                )
                                                              ],
                                                            )),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Material(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedIndex.clear();
                                                        myAnswer = "";
                                                      });
                                                    },
                                                    child: SizedBox(
                                                      height: 45,
                                                      width: 45,
                                                      child: Icon(
                                                          Icons
                                                              .refresh_outlined,
                                                          color: Colors.white),
                                                    )),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      InkWell(
                                        onTap: () {
                                          if (equalsIgnoreCase(myAnswer,
                                              newQuestion[index].title)) {
                                            context
                                                .read<QuestionControllerBloc>()
                                                .add(ClickSubmit(
                                                    isCorrect: true));
                                          } else {
                                            context
                                                .read<QuestionControllerBloc>()
                                                .add(ClickSubmit(
                                                    isCorrect: false));
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.blue),
                                          child: Center(
                                              child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
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
