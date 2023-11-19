import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/user/user_bloc.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/user_profile_model.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';
import 'package:pino_de_henyo/widgets/snackbar.dart';

class QRResultPage extends StatefulWidget {
  final String qrData;
  final String title;
  const QRResultPage({super.key, required this.qrData, required this.title});

  @override
  State<QRResultPage> createState() => _QRResultPageState();
}

class _QRResultPageState extends State<QRResultPage> {
  var user = allUsers[4];
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is SavedUser) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(saveUserSnackBar())
                  .closed
                  .then((value) {
                Navigator.pop(context);
              });
            }
          },
        ),
      ],
      child: Stack(
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
              child: Padding(
            padding: EdgeInsets.all(20),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackButton(text: widget.title),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 300,
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(.6)),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                user.userName,
                                textAlign: TextAlign.center,
                                style: largeTitleBlack(true)
                                    .copyWith(color: Colors.red),
                              ),
                              Expanded(
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "• Magbasa  (Level ${user.writingLevel})",
                                          style: smallTitleBlack(false)),
                                      SizedBox(height: 10),
                                      Text(
                                          "• Magsulat  (Level ${user.readingLevel})",
                                          style: smallTitleBlack(false)),
                                      SizedBox(height: 10),
                                      Text(
                                          "• Magsagot  (Level ${user.quizLevel})",
                                          style: smallTitleBlack(false)),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Material(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                                onTap: () {
                                  var userJsonString = jsonEncode(user);
                                  context.read<UserBloc>().add(AddUserInList(
                                      userJsonString: userJsonString));
                                },
                                child: Container(
                                  height: 55,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      "Save",
                                      style: smallTitleWhite(true),
                                    ),
                                  ),
                                )))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
