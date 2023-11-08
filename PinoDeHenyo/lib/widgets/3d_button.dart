import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';

class ThreeDButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final String tag;
  final VoidCallback onPressed;

  const ThreeDButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
    required this.tag,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      highlightColor: color,
      splashColor: color,
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Material(
          elevation: 5,
          shadowColor: color.withOpacity(.5),
          color: Colors.black,
          shape: StadiumBorder(),
          child: Container(
            width: double.infinity,
            height: 55,
            decoration: ShapeDecoration(
              shape: StadiumBorder(),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  color,
                  color.withOpacity(0.9),
                  color.withOpacity(0.6),
                  color.withOpacity(0.2)
                ],
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: tag,
                  transitionOnUserGestures: true,
                  child: Text(
                    text,
                    style: myFonts(Colors.white, 22),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
