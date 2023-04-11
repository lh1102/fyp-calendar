import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color subHeaderClr = Color(0xFF424242);
const Color headerClr = Color(0xFF212121);
const Color hintClr = Color(0xFF616161);
const Color textClr = Colors.black54;
const Color buttonClr = Color(0xFF1A237E);

class Themes {
  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: subHeaderClr,
  ));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: headerClr,
  ));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: headerClr,
      ));
}

TextStyle get hintStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: hintClr,
      ));
}