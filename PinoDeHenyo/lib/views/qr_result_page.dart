import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/user_profile_model.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';

class QRResultPage extends StatefulWidget {
  final String qrData;
  final String title;
  const QRResultPage({super.key, required this.qrData, required this.title});

  @override
  State<QRResultPage> createState() => _QRResultPageState();
}

class _QRResultPageState extends State<QRResultPage> {
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
        SafeArea(
            child: Padding(
          padding: EdgeInsets.all(20),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(text: widget.title),
                SizedBox(height: 50),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 300,
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.6)),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              allUsers[0].userName,
                              textAlign: TextAlign.center,
                              style: largeTitleBlack(true)
                                  .copyWith(color: Colors.red),
                            ),
                            Text(allUsers[0].writingLevel.toString(),
                                textAlign: TextAlign.center,
                                style: smallTitleBlack(false)),
                            Text(allUsers[0].readingLevel.toString(),
                                textAlign: TextAlign.center,
                                style: smallTitleBlack(false)),
                            Text(allUsers[0].quizLevel.toString(),
                                textAlign: TextAlign.center,
                                style: smallTitleBlack(false)),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Material(
                          child: InkWell(
                        onTap: () {},
                        child:
                            Container(padding: EdgeInsets.all(30), color: red),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}
