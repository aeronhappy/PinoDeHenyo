import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pino_de_henyo/views/input_page.dart';
import 'package:pino_de_henyo/widgets/3d_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  PageController pageController = PageController();
  bool isPlay = false;

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
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Image.asset(
              "assets/pino/pino_title.png",
              height: 140,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Hero(
              tag: 'pino_input-tag',
              child: Image.asset(
                "assets/pino/pino_school.png",
                height: 350,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 30),
            Container(
                height: 150,
                child: PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          ThreeDButton(
                            text: 'Play',
                            icon: null,
                            color: Colors.green,
                            height: 60,
                            tag: 'playTags',
                            onPressed: () {
                              pageController.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.decelerate);
                              Feedback.forTap(context);
                            },
                          ),
                          SizedBox(height: 10),
                          ThreeDButton(
                              text: 'Quit',
                              icon: null,
                              color: Colors.red,
                              height: 60,
                              tag: 'quitTags',
                              onPressed: () {
                                Feedback.forTap(context);
                                exit(0);
                              })
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          ThreeDButton(
                            text: 'Ako ay guro',
                            icon: null,
                            color: Colors.deepOrange,
                            height: 60,
                            tag: 'teacher',
                            onPressed: () async {
                              String position = 'Teacher';
                              var sharedPref =
                                  await SharedPreferences.getInstance();
                              sharedPref.setString('position', position);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  maintainState: false,
                                  builder: (context) {
                                    return InputPage(position: position);
                                  },
                                ),
                              );
                              Feedback.forTap(context);
                            },
                          ),
                          SizedBox(height: 10),
                          ThreeDButton(
                              text: 'Ako ay studyante',
                              icon: null,
                              color: Colors.blue,
                              height: 60,
                              tag: 'student',
                              onPressed: () async {
                                String position = 'Student';
                                var sharedPref =
                                    await SharedPreferences.getInstance();
                                sharedPref.setString('position', position);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    maintainState: false,
                                    builder: (context) {
                                      return InputPage(position: position);
                                    },
                                  ),
                                );
                                Feedback.forTap(context);
                              })
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ],
    );
  }
}
