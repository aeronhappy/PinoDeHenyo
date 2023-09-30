import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/question_model.dart';
import 'package:pino_de_henyo/widgets/alert_dialog/correct_answer_popup.dart';
import 'package:pino_de_henyo/widgets/alert_dialog/wrong_answer_popup.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({super.key});

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  TextEditingController textEditingController = TextEditingController();
  PageController pageController = PageController();

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
            title: Text('Writing', style: titleMediumLight),
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
                      Container(
                        height: MediaQuery.of(context).size.height * .25,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: selectedColor),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: textEditingController,
                        textCapitalization: TextCapitalization.characters,
                      ),
                      InkWell(
                        onTap: () {
                          if (textEditingController.text ==
                              questions[index].text) {
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
                              shape: const StadiumBorder(), color: errorColor),
                          child: Center(
                            child: Text('Submit', style: titleLargeDark),
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
