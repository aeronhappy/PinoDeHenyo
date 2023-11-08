// import 'dart:developer';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';
// import 'package:camera/camera.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:hand_signature/signature.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:pino_de_henyo/designs/colors/app_colors.dart';
// import 'package:pino_de_henyo/designs/fonts/text_style.dart';

// class Signature extends StatefulWidget {
//   const Signature({super.key});

//   @override
//   State<Signature> createState() => _SignatureState();
// }

// class _SignatureState extends State<Signature> with WidgetsBindingObserver {
//   final control = HandSignatureControl(
//     threshold: 3.0,
//     smoothRatio: 0.65,
//     velocityRange: 2.0,
//   );

//   CameraController? cameraController;
//   final textRecogniser = TextRecognizer();

//   pictureConverter(File fileImg) async {
//     try {
//       // final inputImage = await InputImage.fromFile(fileImg);
//       // final textDetector = GoogleMlKit.vision.textRecognizer();
//       // RecognizedText recognizedText =
//       //     await textDetector.processImage(inputImage);
//       // await textDetector.close();
//       // answer = "";

//       final inputImage = InputImage.fromFile(fileImg);
//       final recognizerText = await textRecogniser.processImage(inputImage);

//       print(recognizerText.text);
//       setState(() {
//         answer = recognizerText.text;
//       });
//     } catch (e) {
//       log(e.toString());
//     }
//   }

//   // Future<void> readTextImage() async {

//   // }
//   Future<void> requestCameraPermision() async {
//     final status = await Permission.camera.request();
//     isPermissionGranted = status == PermissionStatus.granted;
//   }

//   void initCameraController(List<CameraDescription> cameras) {
//     if (cameraController != null) {
//       return;
//     }
//   }

//   CameraDescription? camera;

//   File? newFile;
//   Uint8List? imageNew = null;
//   String answer = '';
//   bool isPermissionGranted = false;

//   @override
//   void initState() {
//     WidgetsBinding.instance.addObserver(this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           constraints: BoxConstraints.expand(),
//           color: Colors.white,
//           child: HandSignature(
//             control: control,
//             type: SignatureDrawType.arc,
//           ),
//         ),
//         Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Column(
//               children: [
//                 Container(
//                     padding: EdgeInsets.all(10),
//                     color: primaryColor,
//                     child:
//                         imageNew == null ? Container() : Image.file(newFile!)),
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   color: secondaryColor,
//                   child:
//                       imageNew == null ? Container() : Image.memory(imageNew!),
//                 ),
//                 Container(
//                     width: double.infinity,
//                     color: Colors.brown,
//                     padding: EdgeInsets.all(20),
//                     child: Text(answer, style: headlineLargeDark))
//               ],
//             )),
//         Positioned(
//           right: 20,
//           bottom: 20,
//           child: Row(
//             children: [
//               CupertinoButton(
//                 onPressed: () {
//                   control.clear();
//                   setState(() {
//                     imageNew = null;
//                   });
//                 },
//                 child: Text('clear'),
//               ),
//               CupertinoButton(
//                 onPressed: () async {
//                   final svg = control.toSvg();
//                   final img =
//                       await control.toImage(format: ImageByteFormat.png);
//                   final pngBytes = await img!.buffer.asUint8List();
//                   final tempDir = await getTemporaryDirectory();
//                   // final dir = Directory(tempDir.path);
//                   // dir.deleteSync(recursive: true);
//                   var file = await File('${tempDir.path}/image.png').create();
//                   // file.writeAsBytesSync(pngBytes);
//                   pictureConverter(file);
//                   setState(() {
//                     newFile = file;
//                     imageNew = img.buffer.asUint8List();
//                   });
//                 },
//                 child: Text('save'),
//               ),
//             ],
//           ),
//         ),

//         // CustomPaint(
//         //   painter: DebugSignaturePainterCP(
//         //     control: control,
//         //     cp: false,
//         //     cpStart: false,
//         //     cpEnd: false,
//         //   ),
//         // ),
//       ],
//     );
//   }
// }
