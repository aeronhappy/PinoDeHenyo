import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/widgets/3d_button.dart';

wrongAnswerDialog(BuildContext context) {
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
                            Text('OOPS!',
                                style: largeTitleBlack(true)
                                    .copyWith(color: Colors.red)),
                            const SizedBox(height: 20),
                            Text(
                              'Mali ang iyong sagot.\nSubukan muli.',
                              style: bodyBlack.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Column(
                          children: [
                            ThreeDButton(
                                text: "Try Again",
                                icon: null,
                                color: Colors.blue,
                                height: 50,
                                tag: "",
                                onPressed: () {
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
                        child: Image.asset('assets/category/angry.png')),
                  )
                ],
              ),
            ),
          ));
}
