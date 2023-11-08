import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/lesson_category_model.dart';

class LessonInfoPage extends StatelessWidget {
  final LessonCategoryModel lessonCategoryModel;
  const LessonInfoPage({super.key, required this.lessonCategoryModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: transparentBlackColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Material(
            elevation: 2,
            child: Container(
              color: lightSecondarybgColor,
              padding: const EdgeInsets.all(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.width * .7,
                      width: double.infinity,
                      decoration: BoxDecoration(border: Border.all()),
                      child: Hero(
                        tag: '${lessonCategoryModel.title}-tag',
                        child: Image.asset(
                          lessonCategoryModel.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      lessonCategoryModel.title,
                      style: GoogleFonts.titanOne(
                        fontSize: 22.5,
                        decoration: TextDecoration.none,
                        color: Colors.brown,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kahulugan :',
                            style: bodySmallLight,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(lessonCategoryModel.description,
                                style: titleSmallLight),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Halimbawa :',
                            style: bodySmallLight,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(lessonCategoryModel.example,
                                style: titleSmallLight),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
