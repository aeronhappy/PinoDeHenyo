import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double letterSpacing = 0;
double height = 1.5;
double wordSpacing = 1;

TextStyle myFonts(Color color, double fontSize, bool hasShadow) {
  return GoogleFonts.cherryCreamSoda(
    fontSize: fontSize,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    color: color,
    shadows: hasShadow
        ? <Shadow>[
            Shadow(
              offset: Offset(0, 2),
              blurRadius: 5.0,
              color: Colors.black,
            ),
          ]
        : null,
  );
}

TextStyle googleFonts(double fontSize, Color color) {
  return GoogleFonts.baloo2(
      fontSize: fontSize,
      letterSpacing: -.5,
      color: color,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none);
}

TextStyle appBarWhite(bool hasShadow) => myFonts(Colors.white, 22, hasShadow);
TextStyle appBarBlack(bool hasShadow) => myFonts(Colors.black, 22, hasShadow);

// TITLE
TextStyle largeTitleWhite(bool hasShadow) =>
    myFonts(Colors.white, 30, hasShadow);
TextStyle largeTitleBlack(bool hasShadow) =>
    myFonts(Colors.black, 30, hasShadow);

TextStyle smallTitleWhite(bool hasShadow) =>
    myFonts(Colors.white, 18, hasShadow);
TextStyle smallTitleBlack(bool hasShadow) =>
    myFonts(Colors.black, 18, hasShadow);

//BODY
TextStyle bodyWhite = googleFonts(16, Colors.white54);
TextStyle bodyBlack = googleFonts(16, Colors.black54);
