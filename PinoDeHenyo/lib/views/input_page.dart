import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/widgets/3d_button.dart';

class InputPage extends StatefulWidget {
  final String position;
  const InputPage({super.key, required this.position});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController textEditingController = TextEditingController();
  String text1 =
      'Magandang araw! Ako nga pala si Pino.\nMaari ko bang malaman ang iyong pangalan?';

  bool hasName = false;

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
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    height: 400,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.green.shade900.withOpacity(1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              text1,
                              style: largeTitleWhite.copyWith(
                                  fontSize: 24, color: Colors.white),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Colors.black54, width: 2)),
                                child: TextField(
                                    cursorColor: Colors.black,
                                    style: bodyBlack.copyWith(fontSize: 20),
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: "Ilagay ang pangalan dito.",
                                        labelStyle: bodyBlack.copyWith(
                                            color: Colors.black45)),
                                    controller: textEditingController,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value.isEmpty) {
                                          hasName = false;
                                        } else {
                                          hasName = true;
                                        }
                                      });
                                    }),
                              ),
                            ),
                          ],
                        )),
                        SizedBox(width: 50),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: -100,
                    child: Hero(
                        tag: 'pino_input-tags',
                        child: Image.asset(
                          "assets/pino/pino_large.png",
                          height: 300,
                        )),
                  ),
                ],
              ),
              SizedBox(height: 40),
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: hasName ? 1 : 0,
                child: ThreeDButton(
                    text: 'Next',
                    icon: null,
                    color: Colors.green,
                    height: 60,
                    tag: '',
                    onPressed: () {}),
              )
            ],
          ),
        ),
      ],
    );
  }
}
