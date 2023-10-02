import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/repository/injection_container.dart';
import 'package:pino_de_henyo/views/category_page.dart';
import 'package:pino_de_henyo/views/reading_page.dart';
import 'package:pino_de_henyo/views/settings_page.dart';
import 'package:pino_de_henyo/views/writing_page.dart';
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Image.asset(
                'assets/pino/background.png',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/pino/pino_title.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/pino/pino_whole.png',
                fit: BoxFit.fitWidth,
              ),
            ),

            //BUTTON

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                height: MediaQuery.of(context).size.height * .45,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
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
                                child: const CategoryPage(),
                              );
                            },
                          ),
                        );
                      },
                      child: Material(
                        shape: const StadiumBorder(),
                        elevation: 10,
                        child: Container(
                          margin: const EdgeInsets.all(3),
                          width: double.infinity,
                          height: 50,
                          decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      width: 5, color: Colors.brown))),
                          child: Center(
                              child: Text(
                            'MAG-ARAL',
                            style: GoogleFonts.titanOne(
                              fontSize: 22.5,
                              decoration: TextDecoration.none,
                              color: Colors.brown,
                            ),
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
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
                      child: Material(
                        shape: const StadiumBorder(),
                        elevation: 10,
                        child: Container(
                          margin: const EdgeInsets.all(3),
                          width: double.infinity,
                          height: 50,
                          decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      width: 5, color: Colors.brown))),
                          child: Center(
                              child: Text(
                            'MAGSULAT',
                            style: GoogleFonts.titanOne(
                              fontSize: 22.5,
                              decoration: TextDecoration.none,
                              color: Colors.brown,
                            ),
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
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
                      child: Material(
                        shape: const StadiumBorder(),
                        elevation: 10,
                        child: Container(
                          margin: const EdgeInsets.all(3),
                          width: double.infinity,
                          height: 50,
                          decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      width: 5, color: Colors.brown))),
                          child: Center(
                              child: Text(
                            'MAGBASA',
                            style: GoogleFonts.titanOne(
                              fontSize: 22.5,
                              decoration: TextDecoration.none,
                              color: Colors.brown,
                            ),
                          )),
                        ),
                      ),
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
