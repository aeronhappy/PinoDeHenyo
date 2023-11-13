import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';

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
                      color: lightSecondarybgColor,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 60),
                            Text(
                              random == 1 ? 'MAHUSAY!' : 'MAGALING!',
                              style: GoogleFonts.titanOne(
                                  fontSize: 30,
                                  decoration: TextDecoration.none,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Tama ang iyong sagot.',
                              style: largeTitleBlack(true),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                context
                                    .read<QuestionControllerBloc>()
                                    .add(ClickNext());
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: violet,
                                elevation: 2,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              ),
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text('NEXT', style: bodyBlack)),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )),
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
