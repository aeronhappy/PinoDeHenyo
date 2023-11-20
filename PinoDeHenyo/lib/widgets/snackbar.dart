import 'package:flutter/material.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';

saveUserSnackBar() {
  return SnackBar(
      duration: Duration(milliseconds: 500),
      elevation: 0,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(top: 100),
      content: Center(
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
              border: Border.all(width: 2, color: Colors.green)),
          child: Center(
            child: Text(
              'Saved',
              style: smallTitleWhite(true).copyWith(color: Colors.green),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent);
}
