import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/onboard_model.dart';
import 'package:pino_de_henyo/repository/injection_container.dart';
import 'package:pino_de_henyo/views/dashboard_page.dart';
import 'package:pino_de_henyo/widgets/others/tts_voice_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:speech_balloon/speech_balloon.dart';
import 'package:speech_to_text/speech_to_text.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  SpeechToText speechToText = SpeechToText();
  PageController pageController = PageController();

  bool isDone = false;
  bool isStart = false;
  int currentIndex = 0;

  getStarted() async {
    var sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool("doneOnboarding", true);
  }

  textToSpeechOnboarding(String text) async {
    await flutterTts
        .setVoice({"name": "fil-ph-x-fic-local", "locale": "fil-PH"});
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1);
    await flutterTts.setPitch(.6);
    await flutterTts.speak(text);
    await flutterTts.awaitSpeakCompletion(true).whenComplete(() {
      setState(() {
        isDone = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightPrimarybgColor,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Image.asset(
                'assets/pino/bg_splash.jpg',
                fit: BoxFit.fill,
              ),
            ),
            isStart
                ? Column(children: [
                    Expanded(
                      child: PageView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          controller: pageController,
                          itemCount: onboardModel.length,
                          onPageChanged: (index) {
                            textToSpeechOnboarding(onboardModel[index].desc);
                            setState(() {
                              isDone = false;
                              currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  const SizedBox(height: 50),
                                  SpeechBalloon(
                                    nipLocation: NipLocation.bottom,
                                    borderColor: Colors.black,
                                    color: lightPrimarybgColor,
                                    innerBorderRadius: 50,
                                    height:
                                        MediaQuery.of(context).size.width * .7,
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    borderRadius: 50,
                                    borderWidth: 10,
                                    nipHeight: 20,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              .7,
                                      width: MediaQuery.of(context).size.width *
                                          .7,
                                      padding: const EdgeInsets.all(20),
                                      child: Center(
                                        child: Text(
                                          onboardModel[index].desc,
                                          style: headlineSmallLight,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    CircleAvatar(
                      radius: 90,
                      backgroundColor: Colors.red,
                      child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          child: Center(
                              child:
                                  Image.asset('assets/pino/pino_whole.png'))),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * .2,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmoothPageIndicator(
                                controller: pageController,
                                effect: ExpandingDotsEffect(
                                    dotHeight: 5,
                                    dotWidth: 7,
                                    spacing: 5,
                                    dotColor: Colors.brown.shade200,
                                    activeDotColor: Colors.brown),
                                count: onboardModel.length),
                            currentIndex == onboardModel.length - 1
                                ? Padding(
                                    padding: const EdgeInsets.all(40),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(50),
                                      onTap: () {
                                        getStarted();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return MultiBlocProvider(
                                                providers: [
                                                  BlocProvider(
                                                    create: (context) =>
                                                        QuestionControllerBloc(
                                                            sharedPreferences:
                                                                sl()),
                                                  ),
                                                ],
                                                child: const DashboardPage(),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 30),
                                        padding: EdgeInsets.all(20),
                                        decoration: ShapeDecoration(
                                            color: successColor,
                                            shape: StadiumBorder()),
                                        child: Center(
                                            child: Text(
                                          'Play',
                                          style: GoogleFonts.titanOne(
                                            fontSize: 22.5,
                                            decoration: TextDecoration.none,
                                            color: Colors.white,
                                          ),
                                        )),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30, horizontal: 20),
                                    child: SizedBox(
                                      height: 50,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(),
                                          isDone
                                              ? FloatingActionButton(
                                                  onPressed: () {
                                                    pageController.animateToPage(
                                                        currentIndex + 1,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        curve: Curves.linear);
                                                  },
                                                  child: const Icon(
                                                    Icons.arrow_forward_rounded,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  )
                          ],
                        ))
                  ])
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .45,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          'assets/pino/pino_title.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      CircleAvatar(
                        radius: 90,
                        backgroundColor: Colors.red,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/pino/pino_head.png'),
                        ),
                      ),
                      SizedBox(height: 50),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isStart = true;
                          });
                          textToSpeechOnboarding(onboardModel[0].desc);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          padding: EdgeInsets.all(20),
                          decoration: ShapeDecoration(
                              color: successColor, shape: StadiumBorder()),
                          child: Center(
                              child: Text(
                            'Play',
                            style: GoogleFonts.titanOne(
                              fontSize: 22.5,
                              decoration: TextDecoration.none,
                              color: Colors.white,
                            ),
                          )),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          exit(0);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          padding: EdgeInsets.all(20),
                          decoration: ShapeDecoration(
                              color: Colors.red, shape: StadiumBorder()),
                          child: Center(
                              child: Text(
                            'Quit',
                            style: GoogleFonts.titanOne(
                              fontSize: 22.5,
                              decoration: TextDecoration.none,
                              color: Colors.white,
                            ),
                          )),
                        ),
                      )
                    ],
                  ),
          ],
        ));
  }
}
