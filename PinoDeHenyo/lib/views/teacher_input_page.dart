import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/views/teacher_profile_page.dart';
import 'package:pino_de_henyo/widgets/3d_button.dart';
import 'package:pino_de_henyo/widgets/greetings.dart';
import 'package:pino_de_henyo/widgets/music.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherInputPage extends StatefulWidget {
  const TeacherInputPage({super.key});

  @override
  State<TeacherInputPage> createState() => _TeacherInputPageState();
}

class _TeacherInputPageState extends State<TeacherInputPage> {
  TextEditingController textEditingController = TextEditingController();
  String teacherGender = '';
  String teacherName = '';
  bool hasName = false;

  getStarted() async {
    var sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool("doneOnboarding", true);
  }

  @override
  void initState() {
    super.initState();
    textToSpeech("${greetingText()} mahal kong guro.");
  }

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
        Positioned(
            top: 30,
            left: 10,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  Feedback.forTap(context);
                  Navigator.pop(context);
                  flutterTts.stop();
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.arrow_back_rounded,
                      size: 50, color: Colors.white),
                ),
              ),
            )),
        Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height * .5,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.green.shade900.withOpacity(1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${greetingText()} mahal kong guro.",
                            style: smallTitleWhite(true).copyWith(fontSize: 22),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pumili ng iyong kasarian.",
                                textAlign: TextAlign.start,
                                style: bodyWhite,
                              ),
                              SizedBox(height: 5),
                              Material(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () async {
                                    var sharedPref =
                                        await SharedPreferences.getInstance();
                                    await sharedPref.setString(
                                        "teacherGender", 'Ginoo');
                                    setState(() {
                                      teacherGender = "Ginoo";
                                    });
                                  },
                                  child: Container(
                                    width: 200,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: teacherGender == "Ginoo"
                                        ? BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                width: 2, color: Colors.white))
                                        : null,
                                    child: Center(
                                      child: Text(
                                        'Ginoo',
                                        style: smallTitleWhite(false).copyWith(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Material(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () async {
                                    var sharedPref =
                                        await SharedPreferences.getInstance();
                                    await sharedPref.setString(
                                        "teacherGender", 'Ginang');
                                    setState(() {
                                      teacherGender = "Ginang";
                                    });
                                  },
                                  child: Container(
                                    width: 200,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: teacherGender == "Ginang"
                                        ? BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                width: 2, color: Colors.white))
                                        : null,
                                    child: Center(
                                      child: Text(
                                        'Ginang',
                                        style: smallTitleWhite(false).copyWith(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.black54, width: 2)),
                              child: TextField(
                                  cursorColor: Colors.black,
                                  style: bodyBlack,
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
                  right: -110,
                  child: Hero(
                      tag: 'pino_input-tags',
                      child: Image.asset(
                        "assets/pino/pino_large.png",
                        height: 300,
                      )),
                ),
              ]),
              SizedBox(height: 20),
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: hasName && teacherGender != "" ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ThreeDButton(
                      text: 'Next',
                      icon: null,
                      color: Colors.green,
                      height: 60,
                      tag: 'next-tag',
                      onPressed: () async {
                        var sharedPref = await SharedPreferences.getInstance();
                        sharedPref.setString('teacherGender', teacherGender);
                        sharedPref.setString(
                            'teacherName', textEditingController.text);
                        getStarted();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const TeacherProfilePage();
                            },
                          ),
                        );
                      }),
                ),
              )
            ])
      ],
    );
  }
}
