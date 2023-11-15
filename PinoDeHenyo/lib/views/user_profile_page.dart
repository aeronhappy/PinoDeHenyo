import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/user_profile_model.dart';
import 'package:pino_de_henyo/views/generate_qr.dart';
import 'package:pino_de_henyo/views/settings_page.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  final String title;
  const UserProfilePage({super.key, required this.title});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Uint8List? myBytes;
  File? myImage;
  String userName = '';
  int writingLevel = 0;
  int readingLevel = 0;
  int quizLevel = 0;
  String base64 = '';

  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  saveFile(File? myImage) async {
    var sharedPref = await SharedPreferences.getInstance();

    final Uint8List bytes = await myImage!.readAsBytes();
    final String base64Image = base64Encode(bytes);
    sharedPref.setString('myImage', base64Image);
    sharedPref.setString('userName', "Aeron Maligaya");
  }

  getUserData() async {
    var sharedPref = await SharedPreferences.getInstance();
    String? base64Image = sharedPref.getString('myImage');
    setState(() {
      if (base64Image != null) {
        myBytes = base64Decode(base64Image);
      }
      base64 = base64Image ?? "";
      userName = sharedPref.getString('userName') ?? '';
      writingLevel = sharedPref.getInt('WritingLevel') ?? 0;
      readingLevel = sharedPref.getInt('ReadingLevel') ?? 0;
      quizLevel = sharedPref.getInt('QuizLevel') ?? 0;

      userModel = UserModel(
          userName: userName,
          // myBytes: myBytes,
          writingLevel: writingLevel,
          readingLevel: readingLevel,
          quizLevel: quizLevel);
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
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(text: 'My Profile'),
                SizedBox(height: 50),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.7),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: myImage != null
                                          ? Image.file(myImage!,
                                              fit: BoxFit.cover)
                                          : myBytes != null
                                              ? Image.memory(myBytes!,
                                                  fit: BoxFit.cover)
                                              : Icon(
                                                  Icons.person_4,
                                                  size: 80,
                                                  color: Colors.white,
                                                ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: InkWell(
                                      onTap: () async {
                                        final returnImage = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        setState(() {
                                          if (returnImage != null) {
                                            myImage = File(returnImage.path);
                                            saveFile(File(returnImage.path));
                                          }
                                          return;
                                        });
                                      },
                                      child: CircleAvatar(
                                        radius: 14,
                                        backgroundColor: Colors.blue,
                                        child: CircleAvatar(
                                          radius: 12.5,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.add_a_photo_rounded,
                                            size: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Text(
                                  userModel!.userName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: largeTitleBlack(true).copyWith(
                                      color: Colors.red, fontSize: 27),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Magbasa",
                                      style: bodyWhite.copyWith(
                                          color: Colors.black,
                                          fontSize: 18,
                                          height: 1)),
                                  SizedBox(height: 10),
                                  Text("Level",
                                      style: smallTitleBlack(true).copyWith(
                                          height: 1,
                                          color: Colors.green,
                                          fontSize: 16)),
                                  SizedBox(height: 5),
                                  Text("${userModel!.readingLevel + 1}",
                                      style: largeTitleWhite(true).copyWith(
                                          height: 1, color: Colors.green)),
                                ],
                              ),
                              Container(
                                height: 45,
                                width: 2,
                                color: Colors.grey.shade700,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Magsulat",
                                      style: bodyWhite.copyWith(
                                          color: Colors.black,
                                          fontSize: 18,
                                          height: 1)),
                                  SizedBox(height: 10),
                                  Text("Level",
                                      style: smallTitleBlack(true).copyWith(
                                          height: 1,
                                          color: Colors.blue,
                                          fontSize: 16)),
                                  SizedBox(height: 5),
                                  Text("${userModel!.writingLevel + 1}",
                                      style: largeTitleWhite(true).copyWith(
                                          height: 1, color: Colors.blue)),
                                ],
                              ),
                              Container(
                                height: 45,
                                width: 2,
                                color: Colors.grey.shade700,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Magsagot",
                                      style: bodyWhite.copyWith(
                                          color: Colors.black,
                                          fontSize: 18,
                                          height: 1)),
                                  SizedBox(height: 10),
                                  Text("Level",
                                      style: smallTitleBlack(true).copyWith(
                                          height: 1,
                                          color: Colors.orangeAccent,
                                          fontSize: 16)),
                                  SizedBox(height: 5),
                                  Text("${userModel!.quizLevel + 1}",
                                      style: largeTitleWhite(true).copyWith(
                                          height: 1,
                                          color: Colors.orangeAccent)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(.7),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    maintainState: false,
                                    builder: (context) => GenerateQrCode(
                                          data: jsonEncode(userModel),
                                        )),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Icon(
                                      Icons.qr_code,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      'Generate QR code',
                                      style: smallTitleBlack(false),
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
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
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
                  ],
                )
              ],
            ),
          ),
        ))
      ],
    );
  }
}
