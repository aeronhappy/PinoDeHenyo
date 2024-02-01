import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/teacher/teacher_bloc.dart';
import 'package:pino_de_henyo/bloc/user/user_bloc.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/teacher_model.dart';
import 'package:pino_de_henyo/repository/injection_container.dart';
import 'package:pino_de_henyo/views/leaderboard_page.dart';
import 'package:pino_de_henyo/views/list_of_student_page.dart';
import 'package:pino_de_henyo/views/qr_scanner_page.dart';
import 'package:pino_de_henyo/views/settings_page.dart';
import 'package:pino_de_henyo/views/teacher_info_page.dart';
import 'package:pino_de_henyo/views/teacher_input_page.dart';
import 'package:pino_de_henyo/widgets/greetings.dart';

class TeacherProfilePage extends StatefulWidget {
  const TeacherProfilePage({super.key});

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  TeacherModel? myTeacher;
  bool isEditMode = false;

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TeacherBloc>().add(GetMyAccount());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeacherBloc, TeacherState>(
      listener: (context, state) {
        if (state is LoadedMyAccount) {
          setState(() {
            myTeacher = state.teacherModel;
          });
        }
      },
      child: Stack(
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
                                        style:
                                            bodyBlack.copyWith(fontSize: 20)),
                                    Container(
                                      child: Text(
                                        myTeacher == null
                                            ? ""
                                            : "${myTeacher!.gender == "Ginoo" ? "Ginoong" : "Ginang"} ${myTeacher!.lastName}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: largeTitleBlack(true).copyWith(
                                            color: Colors.red, fontSize: 27),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(height: 39),
                        Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.7),
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                              create: (context) => UserBloc(
                                                  sharedPreferences: sl()),
                                            ),
                                          ],
                                          child: ListOfStudentPage(
                                            title: 'My Students',
                                          ),
                                        );
                                      },
                                    ),
                                  );

                                  Feedback.forTap(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Icon(
                                          Icons.people_alt_rounded,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        SizedBox(width: 15),
                                        Hero(
                                          tag: "My Students-tag",
                                          child: Text(
                                            'My Students',
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
                                      builder: (context) {
                                        return MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                              create: (context) => UserBloc(
                                                  sharedPreferences: sl()),
                                            ),
                                          ],
                                          child: LeaderboardPage(
                                            title: 'Leaderboard',
                                          ),
                                        );
                                      },
                                    ),
                                  );

                                  Feedback.forTap(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
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
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        maintainState: false,
                                        builder: (context) => QRScannerPage(
                                              title: 'QR Scanner',
                                            )),
                                  );

                                  Feedback.forTap(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Icon(
                                          Icons.qr_code_scanner,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        SizedBox(width: 15),
                                        Hero(
                                          tag: "QR Scanner-tag",
                                          child: Text(
                                            'QR Scanner',
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
                                  padding: EdgeInsets.all(15),
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
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        maintainState: false,
                                        builder: (context) => MultiBlocProvider(
                                              providers: [
                                                BlocProvider(
                                                  create: (context) =>
                                                      TeacherBloc(
                                                          sharedPreferences:
                                                              sl()),
                                                ),
                                                BlocProvider(
                                                  create: (context) => UserBloc(
                                                      sharedPreferences: sl()),
                                                ),
                                              ],
                                              child: TeacherInfoPage(
                                                  teacherModel: myTeacher!),
                                            )),
                                  );
                                  Feedback.forTap(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Icon(
                                          Icons.edit_document,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        SizedBox(width: 15),
                                        Hero(
                                          tag: "Edit-tag",
                                          child: Text(
                                            'Edit Information',
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
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Icon(
                                          Icons.person_add_alt_1_rounded,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        SizedBox(width: 15),
                                        Hero(
                                          tag: "Add Account-tag",
                                          child: Text(
                                            'Add Account',
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
                                  context
                                      .read<TeacherBloc>()
                                      .add(LogoutTeacherAccount());
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        maintainState: false,
                                        builder: (context) => MultiBlocProvider(
                                              providers: [
                                                BlocProvider(
                                                  create: (context) =>
                                                      TeacherBloc(
                                                          sharedPreferences:
                                                              sl()),
                                                ),
                                                BlocProvider(
                                                  create: (context) => UserBloc(
                                                      sharedPreferences: sl()),
                                                ),
                                              ],
                                              child: TeacherInputPage(),
                                            )),
                                  );

                                  Feedback.forTap(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Icon(
                                          Icons.logout_outlined,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        SizedBox(width: 15),
                                        Hero(
                                          tag: "Logout-tag",
                                          child: Text(
                                            'Logout',
                                            style: smallTitleBlack(false),
                                          ),
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
      ),
    );
  }
}
