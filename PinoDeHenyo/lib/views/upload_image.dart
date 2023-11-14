import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        InkWell(
          onTap: (() async {
            final returnImage =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            setState(() {
              selectedImage = File(returnImage!.path);
            });
          }),
          child: Container(
            height: 100,
            width: 100,
            color: red,
          ),
        ),
        selectedImage != null ? Image.file(selectedImage!) : Text('No Image')
      ],
    ));
  }
}
