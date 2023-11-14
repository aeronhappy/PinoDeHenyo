import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  // Declare a variable to store the image file
  late File image;

  // Declare a variable to store the server URL
  String _uploadURL = "https://example.com/upload";

  // Create an image picker object
  final ImagePicker picker = ImagePicker();

  // Create a method to pick an image from the gallery
  Future<void> pickImageFromGallery() async {
    // Use the image picker to get the image from the gallery
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // Check if the image is not null
    if (pickedFile != null) {
      // Set the image file to the picked file
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  // Create a method to pick an image from the camera
  Future<void> _pickImageFromCamera() async {
    // Use the image picker to get the image from the camera
    var pickedFile = await picker.pickImage(source: ImageSource.camera);

    // Check if the image is not null
    if (pickedFile != null) {
      // Set the image file to the picked file
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  // Create a method to upload the image to the server
  Future<void> _uploadImage() async {
    // Check if the image file is not null
    if (image != null) {
      // Create a multipart request object
      var request = http.MultipartRequest("POST", Uri.parse(_uploadURL));

      // Create a multipart file object from the image file path
      var multipartFile =
          await http.MultipartFile.fromPath("image", image.path);

      // Add the multipart file to the request
      request.files.add(multipartFile);

      // Send the request and get the response
      var response = await request.send();

      // Print the response status code
      print(response.statusCode);

      // Save the image file to the device
      _saveImage();
    }
  }

  // Create a method to save the image to the device
  Future<void> _saveImage() async {
    // Get the app directory path
    final directory = await getApplicationDocumentsDirectory();

    // Create a file object with the image file path
    final File file = File('${directory.path}/image.jpg');

    // Write the image file bytes to the file object
    await file.writeAsBytes(image.readAsBytesSync());

    // Print the file path
    print(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Check if the image file is not null
            if (image != null)
              // Display the image file using the Image widget
              Image.file(
                image,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            // Display a row of buttons to pick the image
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Display a button to pick the image from the gallery
                ElevatedButton(
                  onPressed: pickImageFromGallery,
                  child: Text("Gallery"),
                ),
                // Display a button to pick the image from the camera
                ElevatedButton(
                  onPressed: _pickImageFromCamera,
                  child: Text("Camera"),
                ),
              ],
            ),
            // Display a button to upload the image to the server
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
