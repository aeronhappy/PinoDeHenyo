import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/views/generate_qr.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

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
  }

  getUserData() async {
    var sharedPref = await SharedPreferences.getInstance();
    String? base64Image = sharedPref.getString('myImage');

    setState(() {
      if (base64Image != null) {
        myBytes = base64Decode(base64Image);
      }
      userName = sharedPref.getString('userName') ?? '';
      writingLevel = sharedPref.getInt('WritingLevel') ?? 0;
      readingLevel = sharedPref.getInt('ReadingLevel') ?? 0;
      quizLevel = sharedPref.getInt('QuizLevel') ?? 0;
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(100),
                              child: CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Colors.grey,
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
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
                                  )),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () async {
                                  final returnImage = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  setState(() {
                                    if (returnImage != null) {
                                      myImage = File(returnImage.path);
                                      saveFile(File(returnImage.path));
                                    }
                                    return;
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.blue,
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.add_a_photo_rounded,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            userName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: largeTitleBlack(true)
                                .copyWith(color: Colors.red, fontSize: 27),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: transparentWhiteColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
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
                              Text("${readingLevel + 1}",
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
                              Text("${writingLevel + 1}",
                                  style: largeTitleWhite(true)
                                      .copyWith(height: 1, color: Colors.blue)),
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
                              Text("${quizLevel + 1}",
                                  style: largeTitleWhite(true).copyWith(
                                      height: 1, color: Colors.orangeAccent)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Material(
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    maintainState: false,
                                    builder: (context) => GenerateQrCode(
                                          data: 'Aeron Darelle Maligaya',
                                        )),
                              );
                            },
                            child: Padding(padding: EdgeInsets.all(20)))),
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
