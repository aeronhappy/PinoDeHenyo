import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pino_de_henyo/bloc/user/user_bloc.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/repository/injection_container.dart';
import 'package:pino_de_henyo/views/qr_result_page.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';

class QRScannerPage extends StatefulWidget {
  final String title;
  const QRScannerPage({super.key, required this.title});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool isScanCompleted = false;
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
            'assets/pino/14.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        SafeArea(
            child: Padding(
          padding: EdgeInsets.all(20),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(text: widget.title),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Place the code in the area!",
                        style: smallTitleWhite(false),
                      ),
                      Text("Scanning will be started automatically.",
                          style: bodyBlack),
                      SizedBox(height: 30),
                      Center(
                        child: Container(
                          height: 300,
                          width: 300,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(width: 5, color: Colors.white),
                              borderRadius: BorderRadius.circular(20)),
                          child: MobileScanner(onDetect: (capture) {
                            if (!isScanCompleted) {
                              final List<Barcode> barcodes = capture.barcodes;
                              String qrCode = "no data";
                              for (final barcode in barcodes) {
                                qrCode = barcode.rawValue ?? "no data";
                              }
                              setState(() {
                                isScanCompleted = true;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) =>
                                              UserBloc(sharedPreferences: sl()),
                                        ),
                                      ],
                                      child: QRResultPage(
                                          qrData: qrCode, title: 'QR Result'),
                                    );
                                  },
                                ),
                              );
                            }
                          }),
                        ),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}
