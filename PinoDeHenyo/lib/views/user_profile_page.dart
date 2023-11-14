import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/views/upload_image.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
              children: [
                CustomBackButton(text: 'My Profile'),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          maintainState: false,
                          builder: (context) => UploadImage()),
                    );
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    color: red,
                  ),
                )
              ],
            ),
          ),
        ))
      ],
    );
  }
}
