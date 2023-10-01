import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/lesson_model.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PageView.builder(
      itemBuilder: ((context, index) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Text(lessonList[index].title, style: titleLargeLight),
            Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.width * .7,
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all()),
              child: Image.network(
                lessonList[index].image,
                fit: BoxFit.fill,
              ),
            ),
            Text(lessonList[index].description, style: labelLargeLight),
          ]),
        );
      }),
    ));
  }
}
