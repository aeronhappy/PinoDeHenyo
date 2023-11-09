import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/lesson_category_model.dart';
import 'package:pino_de_henyo/widgets/alert_dialog/correct_answer_popup.dart';
import 'package:pino_de_henyo/widgets/alert_dialog/level_pop_up.dart';
import 'package:pino_de_henyo/widgets/alert_dialog/wrong_answer_popup.dart';
import 'package:pino_de_henyo/widgets/others/tts_voice_settings.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({super.key});

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
    return BlocListener<QuestionControllerBloc, QuestionControllerState>(
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
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        }
      },
      child: Scaffold(
          backgroundColor: lightPrimarybgColor,
          appBar: AppBar(
            title: Text('MAGSULAT', style: appBarBlack),
            backgroundColor: lightPrimarybgColor,
            iconTheme: Theme.of(context).iconTheme,
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                    onTap: () {
                      levelDialog(context, mylevel, 'MAGSULAT');
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
                            style: titleBlack,
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
                      .add(SaveWritingLevel(level: index));
                }
              },
              itemCount: newQuestion.length,
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
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: newQuestion[index].title.length,
                            itemBuilder: (context, stringIndex) {
                              return Container(
                                width: 40,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2.5),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Center(
                                    child: Text(
                                  newQuestion[index]
                                      .title[stringIndex]
                                      .toUpperCase(),
                                  style: titleBlack,
                                )),
                              );
                            },
                          ),
                        ),
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
                        textCapitalization: TextCapitalization.characters,
                      ),
                      InkWell(
                        onTap: () {
                          if (equalsIgnoreCase(textEditingController.text,
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
                              shape: const StadiumBorder(), color: Colors.blue),
                          child: Center(
                              child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )),
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
