import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';

class BoxButton extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final VoidCallback ontap;

  const BoxButton(
      {super.key,
      required this.title,
      required this.image,
      required this.color,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: color,
      splashColor: color,
      borderRadius: BorderRadius.circular(20),
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(20),
          child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: color.withOpacity(.9),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(image)),
                  Hero(
                    tag: '$title-tag',
                    child: Text(title,
                        style: smallTitleWhite(true).copyWith(fontSize: 18)),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
