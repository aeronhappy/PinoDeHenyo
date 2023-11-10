import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';

class CustomBackButton extends StatelessWidget {
  final String text;
  final String tag;
  const CustomBackButton({super.key, required this.text, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 20,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Feedback.forTap(context);
            Navigator.pop(context);
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Material(
              elevation: 0,
              color: Colors.transparent,
              shape: StadiumBorder(),
              child: Container(
                height: 60,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_rounded,
                      size: 35,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Hero(
                      tag: tag,
                      transitionOnUserGestures: true,
                      child: Text(
                        text,
                        style: titleWhite.copyWith(
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
