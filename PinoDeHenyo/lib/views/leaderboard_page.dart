import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/user/user_bloc.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/game_model.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';

class LeaderboardPage extends StatefulWidget {
  final String title;
  const LeaderboardPage({super.key, required this.title});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  PageController pageController = PageController();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context
        .read<UserBloc>()
        .add(GetAllUserRankingByGame(gameName: gameName[selectedIndex]));
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
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomBackButton(text: widget.title),
                  SizedBox(height: 50),
                  Expanded(
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white),
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: gameName.length,
                          itemBuilder: (context, index) {
                            return Material(
                                color: selectedIndex == index
                                    ? Colors.red
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                child: InkWell(
                                  highlightColor: Colors.red.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () {
                                    context.read<UserBloc>().add(
                                        GetAllUserRankingByGame(
                                            gameName: gameName[index]));
                                    setState(() {
                                      selectedIndex = index;
                                      pageController.animateToPage(index,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.linear);
                                    });
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          .296,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Center(
                                          child: Text(
                                        gameName[index],
                                        style: selectedIndex == index
                                            ? smallTitleWhite(true)
                                                .copyWith(fontSize: 14)
                                            : smallTitleBlack(false)
                                                .copyWith(fontSize: 13),
                                      ))),
                                ));
                          }),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.5),
                          borderRadius: BorderRadius.circular(20)),
                      child: PageView.builder(
                          controller: pageController,
                          itemCount: gameName.length,
                          onPageChanged: (value) {
                            context.read<UserBloc>().add(
                                GetAllUserRankingByGame(
                                    gameName: gameName[value]));
                            setState(() {
                              selectedIndex = value;
                            });
                          },
                          itemBuilder: (context, gameIndex) {
                            return BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                if (state is LoadedAllUsers) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Center(
                                                child: Text("Rank",
                                                    style:
                                                        smallTitleBlack(false)
                                                            .copyWith(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .red))),
                                            Center(
                                              child: Text("Name",
                                                  style: smallTitleBlack(false)
                                                      .copyWith(
                                                          fontSize: 15,
                                                          color: Colors.red)),
                                            ),
                                            Center(
                                                child: Text(
                                              "Level",
                                              style: smallTitleBlack(false)
                                                  .copyWith(
                                                      fontSize: 15,
                                                      color: Colors.red),
                                            ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Expanded(
                                        child: state.users.length == 0
                                            ? Center(
                                                child: Text(
                                                "To add a student, you must first scan and save student data.",
                                                textAlign: TextAlign.center,
                                                style: bodyBlack,
                                              ))
                                            : ListView.builder(
                                                itemCount: state.users.length,
                                                itemBuilder:
                                                    (context, userIndex) {
                                                  var user =
                                                      state.users[userIndex];
                                                  int gameLevel() {
                                                    int level = 0;
                                                    if (gameIndex == 0) {
                                                      level = user.quizLevel;
                                                    }
                                                    if (gameIndex == 1) {
                                                      level = user.readingLevel;
                                                    }
                                                    if (gameIndex == 2) {
                                                      level = user.writingLevel;
                                                    }
                                                    return level;
                                                  }

                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 5),
                                                    child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                              width: 45,
                                                              height: 45,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .blue,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12)),
                                                              child: Center(
                                                                child: Text(
                                                                    "${userIndex + 1}",
                                                                    style: smallTitleWhite(
                                                                        true)),
                                                              )),
                                                          SizedBox(width: 20),
                                                          Expanded(
                                                            child: Text(
                                                              user.userName,
                                                              style: smallTitleBlack(
                                                                      false)
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Container(
                                                              width: 45,
                                                              child: Center(
                                                                child: Text(
                                                                    "Lvl. ${gameLevel() + 1}",
                                                                    style: bodyBlack.copyWith(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            18)),
                                                              )),
                                                        ]),
                                                  );
                                                }),
                                      ),
                                    ],
                                  );
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            );
                          }),
                    ))
                  ]))
                ]),
          ),
        ))
      ],
    );
  }
}
