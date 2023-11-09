import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/repository/injection_container.dart';
import 'package:pino_de_henyo/views/category_page.dart';
import 'package:pino_de_henyo/views/quiz_page.dart';
import 'package:pino_de_henyo/views/reading_page.dart';
import 'package:pino_de_henyo/views/settings_page.dart';
import 'package:pino_de_henyo/views/writing_page.dart';
import 'package:pino_de_henyo/widgets/3d_button.dart';
import 'package:pino_de_henyo/widgets/others/bg_music.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int bgIndex = 0;
  double musicVolume = 0.5;
  getSounds() async {
    var share = await SharedPreferences.getInstance();
    setState(() {
      bgIndex = share.getInt('Music') ?? 0;
      musicVolume = share.getDouble('MusicVolume') ?? .5;
    });
    playMusic(bgIndex, musicVolume);
  }

  @override
  void initState() {
    super.initState();
    getSounds();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: 0,
            //   top: 0,
            //   child: Image.asset(
            //     'assets/pino/background.png',
            //     fit: BoxFit.fill,
            //   ),
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * .5,
            //   width: MediaQuery.of(context).size.width,
            //   child: Image.asset(
            //     'assets/pino/pino_title.png',
            //     fit: BoxFit.fitWidth,
            //   ),
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   child: Image.asset(
            //     'assets/pino/pino_whole.png',
            //     fit: BoxFit.fitWidth,
            //   ),
            // ),

            //BUTTON

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                height: MediaQuery.of(context).size.height * .5,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ThreeDButton(
                        text: 'MAG-ARAL',
                        icon: Icons.play_arrow,
                        color: lightSecondaryTextColor,
                        height: 50,
                        tag: 'magaral-tag',
                        onPressed: () {
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
                                  child: CategoryPage(),
                                );
                              },
                            ),
                          );
                        }),
                    SizedBox(height: 10),
                    ThreeDButton(
                      text: 'MAGSULAT',
                      icon: Icons.play_arrow,
                      color: Colors.green,
                      height: 50,
                      tag: 'magsulat-tag',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => QuestionControllerBloc(
                                        sharedPreferences: sl()),
                                  ),
                                ],
                                child: const WritingPage(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    ThreeDButton(
                      text: 'MAGBASA',
                      icon: Icons.play_arrow,
                      color: Colors.blue,
                      height: 50,
                      tag: 'magbasa-tag',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            maintainState: false,
                            builder: (context) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => QuestionControllerBloc(
                                        sharedPreferences: sl()),
                                  ),
                                ],
                                child: const ReadingPage(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    ThreeDButton(
                      text: 'MAGSAGOT',
                      icon: Icons.play_arrow,
                      color: Colors.pink,
                      height: 50,
                      tag: 'magsagot-tag',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            maintainState: false,
                            builder: (context) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => QuestionControllerBloc(
                                        sharedPreferences: sl()),
                                  ),
                                ],
                                child: const QuizPage(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 30,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        maintainState: false,
                        builder: (context) => SettingsPage()),
                  );
                },
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.brown,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.settings,
                        color: Colors.brown,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
