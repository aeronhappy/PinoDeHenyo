import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';

class ExampleWritePage extends StatefulWidget {
  const ExampleWritePage({super.key});

  @override
  State<ExampleWritePage> createState() => _ExampleWritePageState();
}

class _ExampleWritePageState extends State<ExampleWritePage> {
  SignatureController signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.red,
      exportBackgroundColor: Colors.amber);

  Uint8List? exportedImage;
  final textDetector = GoogleMlKit.vision.textRecognizer();
  String myText = '';
  String filePath = '';

  getImageBytes() async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = await imageFile!.readAsBytes();

    exportedImage = bytes;
    filePath = await imageFile.path;
    setState(() {});
  }

  recognizeText(Uint8List imageBytes) async {
    final inputImage = InputImage.fromBytes(
      bytes: imageBytes,
      inputImageData: InputImageData(
          size: Size(300, 300),
          imageRotation: InputImageRotation.rotation0deg,
          inputImageFormat: InputImageFormat.nv21,
          planeData: List.empty()),
    );
    myText =
        await textDetector.processImage(inputImage).then((value) => value.text);
  }

  recognizeTextFromFilePath(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    myText =
        await textDetector.processImage(inputImage).then((value) => value.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          color: Colors.red,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Signature(
                controller: signatureController,
                height: 200,
                backgroundColor: Colors.blue,
              ),
              Row(
                children: [
                  Material(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () async {
                          exportedImage =
                              await signatureController.toPngBytes();
                        },
                        child: Container(
                            padding: EdgeInsets.all(10), child: Text("Save"))),
                  ),
                  Material(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          signatureController.clear();
                        },
                        child: Container(
                            padding: EdgeInsets.all(10), child: Text("Clear"))),
                  ),
                  Material(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () async {
                          getImageBytes();
                        },
                        child: Container(
                            padding: EdgeInsets.all(10), child: Text("Undo"))),
                  ),
                  Material(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          // recognizeText(exportedImage!);
                          recognizeTextFromFilePath(filePath);
                        },
                        child: Container(
                            padding: EdgeInsets.all(10), child: Text("Redo"))),
                  )
                ],
              ),
              Container(
                height: 200,
                child: exportedImage != null
                    ? Image.memory(exportedImage!)
                    : Center(
                        child: Text("No Image"),
                      ),
              ),
              Text("$filePath (file path)"),
              Text("$myText ---  text ako")
            ],
          )),
    );
  }
}
