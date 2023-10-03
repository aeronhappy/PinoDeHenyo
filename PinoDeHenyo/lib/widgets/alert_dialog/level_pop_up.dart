import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/lesson_category_model.dart';

levelDialog(BuildContext context, int levelDone, String fromPage) {
  showDialog(
      context: context,
      builder: (_) => Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    color: lightSecondarybgColor,
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Choose Level',
                      style: titleLargeLight,
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 90,
                                childAspectRatio: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: lessonCategoryList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Material(
                            child: InkWell(
                              onTap: levelDone >= index
                                  ? () {
                                      if (fromPage == 'MAGSULAT') {
                                        context
                                            .read<QuestionControllerBloc>()
                                            .add(ChangeWritingLevel(
                                                levelSelected: index));
                                      }
                                      if (fromPage == 'MAGBASA') {
                                        context
                                            .read<QuestionControllerBloc>()
                                            .add(ChangeReadingLevel(
                                                levelSelected: index));
                                      }
                                      if (fromPage == 'MAGSAGOT') {
                                        context
                                            .read<QuestionControllerBloc>()
                                            .add(ChangeQuizLevel(
                                                levelSelected: index));
                                      }

                                      Navigator.pop(context);
                                    }
                                  : null,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: levelDone >= index
                                        ? Colors.brown
                                        : Colors.brown.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                    child: levelDone >= index
                                        ? Text(
                                            '${index + 1}',
                                            style: titleMediumDark,
                                          )
                                        : Icon(
                                            Icons.lock,
                                            color: Colors.brown,
                                          )),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
}
