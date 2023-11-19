import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pino_de_henyo/bloc/user/user_bloc.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/user_profile_model.dart';
import 'package:pino_de_henyo/views/generate_qr.dart';
import 'package:pino_de_henyo/views/settings_page.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';
import 'package:pino_de_henyo/widgets/delete_popup.dart';
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
  bool isEditMode = false;
  TextEditingController textEditingController = TextEditingController();
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetMyUserName());
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is LoadedMyProfile) {
              setState(() {
                userModel = state.profile;
                textEditingController.text = state.profile.userName;
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
              child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(text: 'My Profile'),
                    SizedBox(height: 50),
                    userModel == null
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(.7),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                Material(
                                                  elevation: 4,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.grey.shade600,
                                                  child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: myImage != null
                                                        ? Image.file(myImage!,
                                                            fit: BoxFit.cover)
                                                        : myBytes != null
                                                            ? Image.memory(
                                                                myBytes!,
                                                                fit: BoxFit
                                                                    .cover)
                                                            : Icon(
                                                                Icons.person_4,
                                                                size: 80,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 5,
                                                  right: 5,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      final returnImage =
                                                          await ImagePicker()
                                                              .pickImage(
                                                                  source: ImageSource
                                                                      .gallery);
                                                      setState(() {
                                                        if (returnImage !=
                                                            null) {
                                                          myImage = File(
                                                              returnImage.path);
                                                          saveFile(File(
                                                              returnImage
                                                                  .path));
                                                        }
                                                        return;
                                                      });
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 14,
                                                      backgroundColor:
                                                          Colors.blue,
                                                      child: CircleAvatar(
                                                        radius: 12.5,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Icon(
                                                          Icons
                                                              .add_a_photo_rounded,
                                                          size: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: isEditMode
                                                  ? Column(
                                                      children: [
                                                        Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black54,
                                                                    width: 2)),
                                                            child: TextField(
                                                              cursorColor:
                                                                  Colors.black,
                                                              style: smallTitleBlack(
                                                                      false)
                                                                  .copyWith(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .red),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              decoration: InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  labelText:
                                                                      "Ilagay ang pangalan dito.",
                                                                  labelStyle: bodyBlack.copyWith(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black45)),
                                                              controller:
                                                                  textEditingController,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Material(
                                                              color:
                                                                  Colors.blue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  var sharedPref =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  await sharedPref.setString(
                                                                      "userName",
                                                                      textEditingController
                                                                          .text);
                                                                  context
                                                                      .read<
                                                                          UserBloc>()
                                                                      .add(
                                                                          GetMyUserName());
                                                                  setState(() {
                                                                    isEditMode =
                                                                        false;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              20,
                                                                          vertical:
                                                                              2),
                                                                  child: Text(
                                                                    'Update',
                                                                    style: bodyWhite
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Material(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    isEditMode =
                                                                        false;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              20,
                                                                          vertical:
                                                                              2),
                                                                  child: Text(
                                                                    'Cancel',
                                                                    style: bodyWhite
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  : Text(
                                                      userModel!.userName,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: largeTitleBlack(
                                                              true)
                                                          .copyWith(
                                                              color: Colors.red,
                                                              fontSize: 27),
                                                    ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 40),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Magbasa",
                                                    style: bodyWhite.copyWith(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        height: 1)),
                                                SizedBox(height: 10),
                                                Text("Level",
                                                    style: smallTitleBlack(true)
                                                        .copyWith(
                                                            height: 1,
                                                            color: Colors.green,
                                                            fontSize: 16)),
                                                SizedBox(height: 5),
                                                Text(
                                                    "${userModel!.readingLevel + 1}",
                                                    style: largeTitleWhite(true)
                                                        .copyWith(
                                                            height: 1,
                                                            color:
                                                                Colors.green)),
                                              ],
                                            ),
                                            Container(
                                              height: 45,
                                              width: 2,
                                              color: Colors.grey.shade700,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Magsulat",
                                                    style: bodyWhite.copyWith(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        height: 1)),
                                                SizedBox(height: 10),
                                                Text("Level",
                                                    style: smallTitleBlack(true)
                                                        .copyWith(
                                                            height: 1,
                                                            color: Colors.blue,
                                                            fontSize: 16)),
                                                SizedBox(height: 5),
                                                Text(
                                                    "${userModel!.writingLevel + 1}",
                                                    style: largeTitleWhite(true)
                                                        .copyWith(
                                                            height: 1,
                                                            color:
                                                                Colors.blue)),
                                              ],
                                            ),
                                            Container(
                                              height: 45,
                                              width: 2,
                                              color: Colors.grey.shade700,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Magsagot",
                                                    style: bodyWhite.copyWith(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        height: 1)),
                                                SizedBox(height: 10),
                                                Text("Level",
                                                    style: smallTitleBlack(true)
                                                        .copyWith(
                                                            height: 1,
                                                            color: Colors
                                                                .orangeAccent,
                                                            fontSize: 16)),
                                                SizedBox(height: 5),
                                                Text(
                                                    "${userModel!.quizLevel + 1}",
                                                    style: largeTitleWhite(true)
                                                        .copyWith(
                                                            height: 1,
                                                            color: Colors
                                                                .orangeAccent)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: isEditMode
                                        ? Container()
                                        : Material(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: InkWell(
                                                onTap: (() {
                                                  setState(() {
                                                    isEditMode = true;
                                                  });
                                                }),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Container(
                                                  height: 35,
                                                  width: 35,
                                                  child: Icon(Icons.edit),
                                                ))),
                                  )
                                ],
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
                                              builder: (context) =>
                                                  GenerateQrCode(
                                                    data: jsonEncode(userModel),
                                                    title: "Generate QR code",
                                                  )),
                                        );
                                        Feedback.forTap(context);
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
                                              Hero(
                                                tag: "Generate QR code-tag",
                                                child: Text(
                                                  'Generate QR code',
                                                  style: smallTitleBlack(false),
                                                ),
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
                                              builder: (context) =>
                                                  SettingsPage()),
                                        );

                                        Feedback.forTap(context);
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
                              SizedBox(height: 10),
                              Material(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.7),
                                  child: InkWell(
                                      onTap: () {
                                        deleteDialogPopUp(context, () async {
                                          var sharedPref =
                                              await SharedPreferences
                                                  .getInstance();
                                          await sharedPref.clear();
                                          Feedback.forTap(context);
                                          exit(0);
                                        }, "If you continue, all of your data as a student will be completely deleted.");
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
                                                Icons.manage_accounts_rounded,
                                                color: Colors.black,
                                                size: 30,
                                              ),
                                              SizedBox(width: 15),
                                              Text(
                                                'Change positon',
                                                style: smallTitleBlack(false),
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
            ),
          ))
        ],
      ),
    );
  }
}
