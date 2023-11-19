import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/widgets/3d_button.dart';

deleteDialogPopUp(BuildContext context, VoidCallback function, String text) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
            child: Container(
              color: Colors.transparent,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
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
                    Text(text,
                        style: smallTitleBlack(false),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 40),
                    Column(
                      children: [
                        ThreeDButton(
                            text: "Continue",
                            icon: null,
                            color: Colors.blue,
                            height: 50,
                            tag: "",
                            onPressed: function),
                        SizedBox(height: 10),
                        ThreeDButton(
                            text: "Cancel",
                            icon: null,
                            color: Colors.red,
                            height: 50,
                            tag: "",
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
}
