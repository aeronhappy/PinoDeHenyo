// import 'dart:ui';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:hand_signature/signature.dart';
// import 'package:pino_de_henyo/designs/colors/app_colors.dart';
// import 'package:pino_de_henyo/designs/fonts/text_style.dart';

// class Signature extends StatefulWidget {
//   const Signature({super.key});

//   @override
//   State<Signature> createState() => _SignatureState();
// }

// class _SignatureState extends State<Signature> {
//   final control = HandSignatureControl(
//     threshold: 3.0,
//     smoothRatio: 0.65,
//     velocityRange: 2.0,
//   );
//   svgToPng(String svgString, BuildContext context) async {
//     final pictureInfo =
//         await vg.loadPicture(SvgStringLoader(svgString), context);

//     final image = await pictureInfo.picture.toImage(100, 100);

//     final byteData = await image.toByteData(format: ImageByteFormat.png);

//     if (byteData == null) {
//       throw Exception('Unable to convert SVG to PNG');
//     }

//     final pngBytes = byteData.buffer.asUint8List();

//     // final textrecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//     // final inputImage = InputImage.fromBytes(bytes: pngBytes,metadata: );

//     // final RecognizedText recognizedText =
//     //     await textrecognizer.processImage(inputImage);

//     // final imgMemory = Image.memory(pngBytes);
//     // return imgMemory;
//   }

//   // Future<void> readTextImage() async {

//   // }

//   var imageNew = null;
//   String answer = '';
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Container(
//           constraints: BoxConstraints.expand(),
//           color: Colors.white,
//           child: HandSignature(
//             control: control,
//             type: SignatureDrawType.arc,
//           ),
//         ),
//         Positioned(
//             top: 60,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: EdgeInsets.all(10),
//               decoration:
//                   ShapeDecoration(color: primaryColor, shape: StadiumBorder()),
//               child: Center(
//                   child: Text(
//                 '',
//                 style: headlineMediumDark,
//               )),
//             )),
//         Positioned(
//           right: 20,
//           bottom: 20,
//           child: Row(
//             children: [
//               CupertinoButton(
//                 onPressed: () {
//                   control.clear();
//                 },
//                 child: Text('clear'),
//               ),
//               CupertinoButton(
//                 onPressed: () async {
//                   final svg = control.toSvg();
//                   final img = control.toImage(format: ImageByteFormat.png);

//                   // setState(() {
//                   //   answer = svg!;
//                   // });
//                   // final newImage = img;
//                   svgToPng(svg!, context);
//                 },
//                 child: Text('save'),
//               ),

//               // image == null ? Container() : Image.memory();
//             ],
//           ),
//         ),
//         Center(child: answer.isEmpty ? Container() : SvgPicture.string(answer))
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
