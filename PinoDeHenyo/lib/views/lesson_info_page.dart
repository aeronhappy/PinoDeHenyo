import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/model/lesson_category_model.dart';

class LessonInfoPage extends StatelessWidget {
  final LessonCategoryModel item;
  const LessonInfoPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 350,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20))),
            child: Center(
              child: Hero(
                  tag: '${item.image}-tags', child: Image.asset(item.image)),
            ),
          ),
        ]),
      ),
    );
  }
}
