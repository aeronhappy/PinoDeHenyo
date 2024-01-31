import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/teacher_model.dart';
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
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isDone = false;

  Future<bool> login() async {
    var sharedPref = await SharedPreferences.getInstance();

    var teacherIndex = teachers
        .indexWhere((element) => element.userName == userNameController.text);

    if (teacherIndex == -1) {
      return false;
    } else {
      if (teachers[teacherIndex].password == passwordController.text) {
        await sharedPref.setInt("teacherId", teachers[teacherIndex].id);
        await sharedPref.setBool("doneOnboarding", true);
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    textToSpeech("${greetingText()} mahal kong guro.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Image.asset(
              'assets/pino/14.png',
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
                        color: Colors.green.shade900,
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
                              style:
                                  smallTitleWhite(true).copyWith(fontSize: 22),
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.black54, width: 2)),
                                  child: TextField(
                                    cursorColor: Colors.black,
                                    style: bodyBlack,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: "Ilagay ang username dito.",
                                        labelStyle: bodyBlack.copyWith(
                                            color: Colors.black45)),
                                    controller: userNameController,
                                    onChanged: (value) {
                                      setState(() {
                                        if (userNameController
                                                .text.isNotEmpty &&
                                            passwordController
                                                .text.isNotEmpty) {
                                          isDone = true;
                                        } else {
                                          isDone = false;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.black54, width: 2)),
                                  child: TextField(
                                    cursorColor: Colors.black,
                                    style: bodyBlack,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: "Ilagay ang password dito.",
                                        labelStyle: bodyBlack.copyWith(
                                            color: Colors.black45)),
                                    controller: passwordController,
                                    onChanged: (value) {
                                      setState(() {
                                        if (userNameController
                                                .text.isNotEmpty &&
                                            passwordController
                                                .text.isNotEmpty) {
                                          isDone = true;
                                        } else {
                                          isDone = false;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
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
                  duration: Duration(milliseconds: 100),
                  opacity: isDone ? 1 : .3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ThreeDButton(
                        text: 'Magpatuloy',
                        icon: null,
                        color: Colors.green,
                        height: 60,
                        tag: 'next-tag',
                        onPressed: isDone
                            ? () async {
                                if (await login()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackbarSuccess("Login successfully"));
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const TeacherProfilePage();
                                      },
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackbarFailed("Login failed."));
                                }
                              }
                            : null),
                  ),
                )
              ])
        ],
      ),
    );
  }
}

snackbarFailed(String msg) {
  return SnackBar(
    content: Text(
      msg,
      style: googleFonts(16, Colors.white),
    ),
    backgroundColor: Colors.red,
  );
}

snackbarSuccess(String msg) {
  return SnackBar(
    duration: const Duration(milliseconds: 500),
    content: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            msg,
            style: googleFonts(16, Colors.white),
          ),
          Icon(Icons.check, size: 20, color: Colors.white)
        ],
      ),
    ),
    backgroundColor: Colors.green,
  );
}
