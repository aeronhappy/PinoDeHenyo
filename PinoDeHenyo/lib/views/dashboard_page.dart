import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/views/reading_page.dart';
import 'package:pino_de_henyo/views/writing_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
              child: Image.network(
                'https://i.pinimg.com/236x/c3/61/bd/c361bd9511a34b2ec0f93998574fbe9e.jpg',
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
                                    create: (context) =>
                                        QuestionControllerBloc(),
                                  ),
                                ],
                                child: const DashboardPage(),
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
                                    create: (context) =>
                                        QuestionControllerBloc(),
                                  ),
                                ],
                                child: const WritingPage(),
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        width: double.infinity,
                        height: 50,
                        decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: StadiumBorder(
                                side:
                                    BorderSide(width: 5, color: Colors.brown))),
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
                                    create: (context) =>
                                        QuestionControllerBloc(),
                                  ),
                                ],
                                child: const ReadingPage(),
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        width: double.infinity,
                        height: 50,
                        decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: StadiumBorder(
                                side:
                                    BorderSide(width: 5, color: Colors.brown))),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
