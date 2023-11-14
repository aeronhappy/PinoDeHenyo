import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrCode extends StatelessWidget {
  final String data;
  const GenerateQrCode({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Container(
        padding: EdgeInsets.all(20),
        child: QrImageView(
          data: data,
          version: QrVersions.auto,
          size: 300.0,
        ),
      )),
    );
  }
}
