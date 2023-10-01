import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/onboard_model.dart';
import 'package:pino_de_henyo/views/dashboard_page.dart';
import 'package:pino_de_henyo/widgets/others/tts_voice_settings.dart';
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

  textToSpeechOnboarding(String text) async {
    await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1);
    await flutterTts.setPitch(0.5);
    await flutterTts.speak(text);
    await flutterTts.awaitSpeakCompletion(true).whenComplete(() {
      setState(() {
        isDone = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    textToSpeechOnboarding(onboardModel[0].desc);
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
              child: Image.network(
                'https://i.pinimg.com/236x/c3/61/bd/c361bd9511a34b2ec0f93998574fbe9e.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Column(children: [
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
                              height: MediaQuery.of(context).size.width * .7,
                              width: MediaQuery.of(context).size.width * .7,
                              borderRadius: 50,
                              borderWidth: 10,
                              nipHeight: 20,
                              child: Container(
                                height: MediaQuery.of(context).size.width * .7,
                                width: MediaQuery.of(context).size.width * .7,
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
                            const SizedBox(height: 50),
                            CircleAvatar(
                              radius: 90,
                              backgroundColor: errorColor,
                              child: CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.white,
                                  child: Center(
                                      child: Image.asset(
                                          'assets/pino/pino_whole.png'))),
                            )
                          ],
                        ),
                      );
                    }),
              ),
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
                                  Navigator.pushReplacement(
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
                                child: Container(
                                  margin: const EdgeInsets.all(3),
                                  width: double.infinity,
                                  height: 50,
                                  decoration: const ShapeDecoration(
                                      color: Colors.brown,
                                      shape: StadiumBorder()),
                                  child: Center(
                                      child: Text(
                                    'Get Started',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: Colors.white),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        onTap: () {
                                          pageController.animateToPage(
                                              onboardModel.length - 1,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.linear);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          decoration: const ShapeDecoration(
                                              shape: StadiumBorder()),
                                          child: Text(
                                            "Skip",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                        )),
                                    isDone
                                        ? FloatingActionButton(
                                            onPressed: () {
                                              pageController.animateToPage(
                                                  currentIndex + 1,
                                                  duration: const Duration(
                                                      milliseconds: 300),
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
            ]),
          ],
        ));
  }
}
