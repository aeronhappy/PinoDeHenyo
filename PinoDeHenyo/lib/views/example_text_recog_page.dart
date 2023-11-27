import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class ExaampleTextRecog extends StatefulWidget {
  const ExaampleTextRecog({super.key});

  @override
  State<ExaampleTextRecog> createState() => _ExaampleTextRecogState();
}

class _ExaampleTextRecogState extends State<ExaampleTextRecog> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "No Text";

  void getImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        recognizedText(pickedImage);
      }
    } catch (_) {
      textScanning = false;
      imageFile = null;
      setState(() {});
      scannedText = "Error";
    }
  }

  void getImageCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        recognizedText(pickedImage);
      }
    } catch (_) {
      textScanning = false;
      imageFile = null;
      setState(() {});
      scannedText = "Error";
    }
  }

  void recognizedText(XFile? image) async {
    final inputImage = InputImage.fromFilePath(image!.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    textScanning = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 400,
            width: 400,
            color: Colors.red,
            child: imageFile != null
                ? Image.file(File(imageFile!.path))
                : Center(child: Text("No data")),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(50),
                child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                        padding: EdgeInsets.all(10), child: Text("Gallery"))),
              ),
              Material(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(50),
                child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      getImageCamera();
                    },
                    child: Container(
                        padding: EdgeInsets.all(10), child: Text("Camera"))),
              )
            ],
          ),
          SizedBox(height: 20),
          Text(scannedText)
        ],
      ),
    );
  }
}
