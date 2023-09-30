import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_app/designs/fonts/text_style.dart';

import '../bloc/question/bloc/question_bloc.dart';
import '../model/quiz_category_model.dart';

class QuizCategoryPage extends StatefulWidget {
  const QuizCategoryPage({super.key});

  @override
  State<QuizCategoryPage> createState() => _QuizCategoryPageState();
}

class _QuizCategoryPageState extends State<QuizCategoryPage> {
  @override
  void initState() {
    super.initState();

    context
        .read<QuestionBloc>()
        .add(const GetRandomQuestions(numberOfQuestions: 10));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        padding: const EdgeInsets.all(20),
        itemCount: quizCategory.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(quizCategory[index].img)),
                    Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Center(
                            child: Opacity(
                          opacity: 0.6,
                          child: Text(
                            quizCategory[index].text,
                            style: titleSmallLight,
                          ),
                        )))
                  ],
                )),
          );
        });

    // return BlocBuilder<QuestionBloc, QuestionState>(
    //   builder: (context, state) {
    //     if (state is LoadedRandomQuestions) {
    //       return ListView.builder(
    //           itemCount: quizCategory.length,
    //           itemBuilder: (context, index) {
    //             return Material(
    //               elevation: 10,
    //               child: Container(
    //                   padding: const EdgeInsets.all(20),
    //                   child: Column(
    //                     children: [
    //                       Text(
    //                         state.randomQuestions[index].text,
    //                         style: bodyMediumLight,
    //                       ),
    //                     ],
    //                   )),
    //             );
    //           });
    //     } else if (state is NoNetworkConnection) {
    //       return Center(
    //           child: Text(
    //         'No Network Connection , Check your internet!',
    //         style: titleMediumLight,
    //       ));
    //     } else {
    //       return const Center(
    //         child: CircularProgressIndicator(color: Colors.redAccent),
    //       );
    //     }
    //   },
    // );
  }
}
