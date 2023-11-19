import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pino_de_henyo/model/user_profile_model.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrCode extends StatefulWidget {
  final String data;
  final String title;
  const GenerateQrCode({super.key, required this.data, required this.title});

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
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: user == null
                ? CircularProgressIndicator()
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(user!.deviceId),
                      SizedBox(height: 10),
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
          ),
        ),
        Positioned(
            top: 40, left: 20, child: CustomBackButton(text: widget.title)),
      ],
    );
  }
}
