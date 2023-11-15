import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/repository/injection_container.dart';
import 'package:pino_de_henyo/views/category_page.dart';
import 'package:pino_de_henyo/views/quiz_page.dart';
import 'package:pino_de_henyo/views/reading_page.dart';
import 'package:pino_de_henyo/views/user_profile_page.dart';
import 'package:pino_de_henyo/views/writing_page.dart';
import 'package:pino_de_henyo/widgets/box_button.dart';
import 'package:pino_de_henyo/widgets/greetings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int bgIndex = 0;
  double musicVolume = 0.5;
  String userName = "";

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  getUserName() async {
    var sharedPref = await SharedPreferences.getInstance();
    setState(() {
      userName = sharedPref.getString('userName') ?? '';
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
            body: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              maintainState: false,
                              builder: (context) => UserProfilePage(
                                    title: 'My Profile',
                                  )),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Material(
                          borderRadius: BorderRadius.circular(50),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade600,
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(50)),
                            child: Hero(
                              tag: 'My Profile-tag',
                              child: Text(
                                'My Profile',
                                style: largeTitleWhite(false)
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Material(
                                borderRadius: BorderRadius.circular(100),
                                elevation: 5,
                                child: CircleAvatar(
                                  backgroundColor: Colors.red.withOpacity(.8),
                                  radius: 70,
                                  child: Center(
                                      child: Image.asset(
                                          'assets/pino/pino_small.png')),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${greetingText()},',
                                    style: bodyBlack.copyWith(
                                        fontSize: 18, letterSpacing: -1),
                                  ),
                                  Text(
                                    '${userName.split(" ")[0]}!',
                                    style: largeTitleBlack(true).copyWith(
                                        color: Colors.red.shade400, height: 1),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ]),
                        GridView.count(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: .8,
                          children: <Widget>[
                            BoxButton(
                                title: 'Mag-aral',
                                image: 'assets/pino/mag-aral.png',
                                color: Colors.amberAccent.shade400,
                                ontap: () {
                                  Feedback.forTap(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                              create: (context) =>
                                                  QuestionControllerBloc(
                                                      sharedPreferences: sl()),
                                            ),
                                          ],
                                          child: CategoryPage(
                                            title: 'Mag-aral',
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }),
                            BoxButton(
                                title: 'Magbasa',
                                image: 'assets/pino/magbasa.png',
                                color: Colors.green,
                                ontap: () {
                                  Feedback.forTap(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                              create: (context) =>
                                                  QuestionControllerBloc(
                                                      sharedPreferences: sl()),
                                            ),
                                          ],
                                          child: ReadingPage(
                                            title: 'Magbasa',
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }),
                            BoxButton(
                                title: 'Magsulat',
                                image: 'assets/pino/magsulat.png',
                                color: Colors.blue,
                                ontap: () {
                                  Feedback.forTap(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                              create: (context) =>
                                                  QuestionControllerBloc(
                                                      sharedPreferences: sl()),
                                            ),
                                          ],
                                          child: WritingPage(
                                            title: 'Magsulat',
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }),
                            BoxButton(
                                title: 'Magsagot',
                                image: 'assets/pino/magsagot.png',
                                color: Colors.deepOrange,
                                ontap: () {
                                  Feedback.forTap(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                              create: (context) =>
                                                  QuestionControllerBloc(
                                                      sharedPreferences: sl()),
                                            ),
                                          ],
                                          child: QuizPage(
                                            title: 'Magsagot',
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Center(
        //     child: Material(
        //   color: Colors.white,
        //   child: Container(
        //     height: 150,
        //     width: 150,
        //     color: red.withOpacity(.2),
        //     child: QrImageView(
        //       data: 'https://pinayflix1.com/',
        //       version: QrVersions.auto,
        //       size: 200.0,
        //     ),
        //   ),
        // ))
      ],
    );
  }
}
