import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import '../fonts/text_style.dart';

ButtonStyle primaryButton = ElevatedButton.styleFrom(
  backgroundColor: primaryColor,
  elevation: 5,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),
  ),
);

buttonPrimary() {
  return Container(
    alignment: Alignment.center,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      child: SizedBox(
        height: 40,
        child: Center(
          child: Text("Post", style: bodyMediumDark),
        ),
      ),
    ),
  );
}
