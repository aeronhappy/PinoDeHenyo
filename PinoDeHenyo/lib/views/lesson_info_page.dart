import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/lesson_category_model.dart';

class LessonInfoPage extends StatelessWidget {
  final LessonCategoryModel item;
  const LessonInfoPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 0,
          child: Image.asset(
            'assets/pino/sky_bg.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Material(
                        elevation: 5,
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20)),
                        child: Container(
                          height: 350,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: item.color,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(20))),
                          child: Center(
                            child: Hero(
                                tag: '${item.image}-tags',
                                child: Image.asset(item.image)),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 30,
                          left: 10,
                          child: InkWell(
                            onTap: () {
                              Feedback.forTap(context);
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.transparent,
                              child: Icon(Icons.arrow_back_rounded,
                                  size: 50, color: Colors.white),
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Text(item.title,
                              style: largeTitleBlack(true)
                                  .copyWith(color: item.color)),
                        ),
                        SizedBox(height: 30),
                        Text('Description', style: smallTitleBlack(false)),
                        SizedBox(height: 10),
                        Text(item.description, style: bodyBlack),
                        SizedBox(height: 30),
                        Text('Example', style: smallTitleBlack(false)),
                        SizedBox(height: 10),
                        Text(item.example, style: bodyBlack),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ],
    );
  }
}
