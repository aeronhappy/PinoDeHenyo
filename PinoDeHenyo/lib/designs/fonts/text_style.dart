import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';

double letterSpacing = 0;
double height = 1.5;
double wordSpacing = 1;

TextStyle myFonts(Color color, double fontSize) {
  return GoogleFonts.titanOne(
    fontSize: fontSize,
    decoration: TextDecoration.none,
    color: color,
  );
}

TextStyle googleFonts(double fontSize, Color color, FontWeight fontWeight) {
  return GoogleFonts.montserrat(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      decoration: TextDecoration.none);
}

TextStyle fontAuthenticationPrimTextStyle =
    googleFonts(30, primaryColor, FontWeight.bold);
TextStyle selectedText = googleFonts(12, successColor, FontWeight.w400);

///////// TEXTTHEME CLASS DARK
// HEADLINE
TextStyle headlineLargeDark =
    googleFonts(32, darkPrimaryTextColor, FontWeight.bold);
TextStyle headlineMediumDark =
    googleFonts(28, darkPrimaryTextColor, FontWeight.bold);
TextStyle headlineSmallDark =
    googleFonts(24, darkPrimaryTextColor, FontWeight.bold);

// TITLE
TextStyle titleLargeDark =
    googleFonts(18, darkPrimaryTextColor, FontWeight.w600);
TextStyle titleMediumDark =
    googleFonts(16, darkPrimaryTextColor, FontWeight.w600);
TextStyle titleSmallDark =
    googleFonts(14, darkPrimaryTextColor, FontWeight.w600);

// BODY
TextStyle bodyLargeDark =
    googleFonts(16, darkPrimaryTextColor, FontWeight.w400);
TextStyle bodyMediumDark =
    googleFonts(14, darkPrimaryTextColor, FontWeight.w400);
TextStyle bodySmallDark =
    googleFonts(12, darkPrimaryTextColor, FontWeight.w400);

//LABEL
TextStyle labelLargeDark =
    googleFonts(12, darkSecondaryTextColor, FontWeight.w300);
TextStyle labelMediumDark =
    googleFonts(10, darkSecondaryTextColor, FontWeight.w300);
TextStyle labelSmallDark =
    googleFonts(8, darkSecondaryTextColor, FontWeight.w300);

///////// TEXTTHEME CLASS LIGHT
// HEADLINE
TextStyle headlineLargeLight =
    googleFonts(32, lightPrimaryTextColor, FontWeight.bold);
TextStyle headlineMediumLight =
    googleFonts(28, lightPrimaryTextColor, FontWeight.bold);
TextStyle headlineSmallLight =
    googleFonts(24, lightPrimaryTextColor, FontWeight.bold);

// TITLE
TextStyle titleLargeLight =
    googleFonts(18, lightPrimaryTextColor, FontWeight.w600);
TextStyle titleMediumLight =
    googleFonts(16, lightPrimaryTextColor, FontWeight.w600);
TextStyle titleSmallLight =
    googleFonts(14, lightPrimaryTextColor, FontWeight.w600);

// BODY
TextStyle bodyLargeLight =
    googleFonts(16, lightPrimaryTextColor, FontWeight.w400);
TextStyle bodyMediumLight =
    googleFonts(14, lightPrimaryTextColor, FontWeight.w400);
TextStyle bodySmallLight =
    googleFonts(12, lightPrimaryTextColor, FontWeight.w400);

//LABEL
TextStyle labelLargeLight =
    googleFonts(12, lightSecondaryTextColor, FontWeight.w300);
TextStyle labelMediumLight =
    googleFonts(10, lightSecondaryTextColor, FontWeight.w300);
TextStyle labelSmallLight =
    googleFonts(8, lightSecondaryTextColor, FontWeight.w300);
