import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/views/settings_page.dart';
import 'package:pino_de_henyo/widgets/greetings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherProfilePage extends StatefulWidget {
  const TeacherProfilePage({super.key});

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  String teacherName = '';
  String teacherGender = '';
  bool isEditMode = false;

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTeacherData();
  }

  getTeacherData() async {
    var sharedPref = await SharedPreferences.getInstance();
    setState(() {
      teacherGender = sharedPref.getString('teacherGender') ?? '';
      teacherName = sharedPref.getString('teacherName') ?? '';
      textEditingController.text = teacherName;
    });
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
        SafeArea(
            child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.7),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Text(greetingText(),
                                      style: bodyBlack.copyWith(fontSize: 20)),
                                  Container(
                                    child: isEditMode
                                        ? Column(
                                            children: [
                                              Material(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      border: Border.all(
                                                          color: Colors.black54,
                                                          width: 2)),
                                                  child: TextField(
                                                    cursorColor: Colors.black,
                                                    style:
                                                        smallTitleBlack(false)
                                                            .copyWith(
                                                                fontSize: 15,
                                                                color:
                                                                    Colors.red),
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        labelText:
                                                            "Ilagay ang pangalan dito.",
                                                        labelStyle:
                                                            bodyBlack.copyWith(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black45)),
                                                    controller:
                                                        textEditingController,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Material(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        var sharedPref =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        await sharedPref.setString(
                                                            "teacherName",
                                                            textEditingController
                                                                .text);
                                                        setState(() {
                                                          getTeacherData();
                                                          isEditMode = false;
                                                        });
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20,
                                                                vertical: 2),
                                                        child: Text(
                                                          'Update',
                                                          style: bodyWhite
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Material(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          isEditMode = false;
                                                        });
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20,
                                                                vertical: 2),
                                                        child: Text(
                                                          'Cancel',
                                                          style: bodyWhite
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        : Text(
                                            "${teacherGender == "Ginoo" ? "Ginoong" : teacherGender} $teacherName",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: largeTitleBlack(true)
                                                .copyWith(
                                                    color: Colors.red,
                                                    fontSize: 27),
                                          ),
                                  ),
                                ],
                              )),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: isEditMode
                                ? Container()
                                : Material(
                                    borderRadius: BorderRadius.circular(100),
                                    child: InkWell(
                                        onTap: (() {
                                          setState(() {
                                            isEditMode = true;
                                          });
                                        }),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          child: Icon(Icons.edit),
                                        ))),
                          )
                        ],
                      ),
                      SizedBox(height: 50),
                      Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(.7),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      maintainState: false,
                                      builder: (context) => SettingsPage()),
                                );

                                Feedback.forTap(context);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Icon(
                                        Icons.leaderboard,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      SizedBox(width: 15),
                                      Hero(
                                        tag: "Leaderboard-tag",
                                        child: Text(
                                          'Leaderboard',
                                          style: smallTitleBlack(false),
                                        ),
                                      )
                                    ]),
                                    Icon(Icons.arrow_forward_ios),
                                  ],
                                ),
                              ))),
                      SizedBox(height: 10),
                      Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(.7),
                          child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Icon(
                                        Icons.qr_code,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      SizedBox(width: 15),
                                      Hero(
                                        tag: "Generate QR code-tag",
                                        child: Text(
                                          'Generate QR code',
                                          style: smallTitleBlack(false),
                                        ),
                                      )
                                    ]),
                                    Icon(Icons.arrow_forward_ios),
                                  ],
                                ),
                              ))),
                      SizedBox(height: 10),
                      Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(.7),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      maintainState: false,
                                      builder: (context) => SettingsPage()),
                                );

                                Feedback.forTap(context);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Icon(
                                        Icons.settings,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      SizedBox(width: 15),
                                      Hero(
                                        tag: "Settings-tag",
                                        child: Text(
                                          'Settings',
                                          style: smallTitleBlack(false),
                                        ),
                                      )
                                    ]),
                                    Icon(Icons.arrow_forward_ios),
                                  ],
                                ),
                              ))),
                      SizedBox(height: 10),
                      Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(.7),
                          child: InkWell(
                              onTap: () async {
                                var sharedPref =
                                    await SharedPreferences.getInstance();
                                await sharedPref.clear();
                                Feedback.forTap(context);
                                exit(0);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Icon(
                                        Icons.manage_accounts_rounded,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        'Change positon',
                                        style: smallTitleBlack(false),
                                      )
                                    ]),
                                    Icon(Icons.arrow_forward_ios),
                                  ],
                                ),
                              ))),
                    ],
                  )
                ],
              ),
            ),
          ),
        ))
      ],
    );
  }
}
