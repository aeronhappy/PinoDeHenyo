import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double letterSpacing = 0;
double height = 1.5;
double wordSpacing = 1;

TextStyle myFonts(Color color, double fontSize) {
  return GoogleFonts.sigmarOne(
    fontSize: fontSize,
    decoration: TextDecoration.none,
    color: color,
  );
}

TextStyle googleFonts(double fontSize, Color color) {
  return GoogleFonts.bubblegumSans(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none);
}

TextStyle appBarWhite = myFonts(Colors.white, 22);
TextStyle appBarBlack = myFonts(Colors.black, 22);

// TITLE
TextStyle largeTitleWhite = myFonts(Colors.white, 30);
TextStyle largeTitleBlack = myFonts(Colors.black, 30);

TextStyle smallTitleWhite = myFonts(Colors.white, 20);
TextStyle smallTitleBlack = myFonts(Colors.black, 20);

TextStyle titleWhite = myFonts(Colors.white, 26);
TextStyle titleBlack = myFonts(Colors.black, 26);

//BODY
TextStyle bodyWhite = googleFonts(18, Colors.white);
TextStyle bodyBlack = googleFonts(18, Colors.black87);
