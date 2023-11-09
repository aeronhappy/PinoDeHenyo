import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';

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
                            Text(
                              'OOPS!',
                              style: GoogleFonts.titanOne(
                                  fontSize: 30,
                                  decoration: TextDecoration.none,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Mali ang iyong sagot.\nSubukan muli.',
                              style: titleBlack,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
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
                                    child:
                                        Text('TRY AGAIN', style: titleBlack)),
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
                        child: Image.asset('assets/category/angry.png')),
                  )
                ],
              ),
            ),
          ));
}
