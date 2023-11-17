import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/repository/injection_container.dart';
import 'package:pino_de_henyo/views/dashboard_page.dart';
import 'package:pino_de_henyo/widgets/3d_button.dart';
import 'package:pino_de_henyo/widgets/music.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputPage extends StatefulWidget {
  final String position;
  const InputPage({super.key, required this.position});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController textEditingController = TextEditingController();
  PageController pageController = PageController();

  var text = [
    'Magandang araw! Ako nga pala si Pino.\nMaari ko bang malaman ang iyong pangalan?',
    'Narito ako upang ipaalam sa iyo ang kahulugan ng salitang \'Mother Tongue\'. Ito ay salitang Ingles na tumutukoy sa unang wika o katutubong wika. Wikang natutunan ng isang tao mula sa pagkabata.',
    'Sa Tagalog, ito ay maaaring isalin bilang \'inang-wika\' o \'katutubong wika\'.Halika\'t samahan mo ko at pag-aralan natin ang mga wikang Filipino.'
  ];
  String userName = '';
  bool hasName = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    textToSpeech(text[0]);
  }

  getStarted() async {
    var sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool("doneOnboarding", true);
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 400,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.green.shade900.withOpacity(1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: pageController,
                        onPageChanged: (index) async {
                          if (index == 1) {
                            setState(() {
                              currentIndex = index;
                            });
                            textToSpeech('Kamusta $userName ? ${text[index]}');
                          }

                          if (index == 2) {
                            setState(() {
                              currentIndex = index;
                            });
                            textToSpeech(text[index]);
                          }
                        },
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                text[0],
                                style: bodyWhite.copyWith(
                                    fontSize: 24, color: Colors.white),
                              ),
                              SizedBox(height: 20),
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
                                          labelText:
                                              "Ilagay ang pangalan dito.",
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
                          ),
                          Center(
                            child: Text(
                              'Kamusta ${userName.toUpperCase()} ?\n${text[1]}',
                              style: bodyWhite.copyWith(
                                  fontSize: 23,
                                  color: Colors.white,
                                  height: 1.2),
                            ),
                          ),
                          Center(
                            child: Text(
                              text[2],
                              style: bodyWhite.copyWith(
                                  fontSize: 23,
                                  color: Colors.white,
                                  height: 1.5),
                            ),
                          ),
                        ],
                      )),
                      SizedBox(width: 60),
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
              ],
            ),
            SizedBox(height: 40),
            AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: hasName ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ThreeDButton(
                    text: 'Next',
                    icon: null,
                    color: Colors.green,
                    height: 60,
                    tag: 'next-tag',
                    onPressed: () async {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                      if (currentIndex == 0) {
                        var sharedPref = await SharedPreferences.getInstance();
                        sharedPref.setString(
                            'userName', textEditingController.text);
                        setState(() {
                          userName = textEditingController.text;
                        });
                      }
                      if (currentIndex == 2) {
                        getStarted();
                        Navigator.pushReplacement(
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
                                child: const DashboardPage(),
                              );
                            },
                          ),
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ],
    );
  }
}
