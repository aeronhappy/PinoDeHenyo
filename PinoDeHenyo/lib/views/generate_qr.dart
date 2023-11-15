import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pino_de_henyo/model/user_profile_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrCode extends StatefulWidget {
  final String data;
  const GenerateQrCode({super.key, required this.data});

  @override
  State<GenerateQrCode> createState() => _GenerateQrCodeState();
}

class _GenerateQrCodeState extends State<GenerateQrCode> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    user = UserModel.fromJson(jsonDecode(widget.data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(user!.userName),
          Text(user!.writingLevel.toString()),
          Text(user!.readingLevel.toString()),
          Text(user!.quizLevel.toString()),
          Container(
            padding: EdgeInsets.all(20),
            child: QrImageView(
              data: widget.data,
              version: QrVersions.auto,
              size: 300.0,
            ),
          ),
        ],
      ),
    );
  }
}
