import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/widgets/3d_button.dart';

correctAnswerDialog(BuildContext context) {
  var rng = Random();
  int random = rng.nextInt(2);

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 60),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: lightSecondarybgColor.withOpacity(.85),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 60),
                            Text(random == 1 ? 'MAHUSAY!' : 'MAGALING!',
                                style: largeTitleBlack(true).copyWith(
                                    color: random == 1
                                        ? Colors.green
                                        : Colors.blue)),
                            const SizedBox(height: 20),
                            Text(
                              'Tama ang iyong sagot.',
                              style: bodyBlack.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Column(
                          children: [
                            ThreeDButton(
                                text: "Next",
                                icon: null,
                                color: random == 1 ? Colors.blue : Colors.green,
                                height: 50,
                                tag: "",
                                onPressed: () {
                                  context
                                      .read<QuestionControllerBloc>()
                                      .add(ClickNext());
                                  Navigator.pop(context);
                                }),
                            SizedBox(height: 10),
                            ThreeDButton(
                                text: "Cancel",
                                icon: null,
                                color: Colors.red,
                                height: 50,
                                tag: "",
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: SizedBox(
                        height: 120,
                        child: Image.asset(random == 1
                            ? 'assets/category/amazing.png'
                            : 'assets/category/right.png')),
                  )
                ],
              ),
            ),
          ));
}
