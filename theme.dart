import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const background = Color(0xFF543A20);
  static const card = Color(0xFFCE9760);
  static const banner = Color(0x7DCE9760);
  static const dark = Color(0xFF543A20);
}

TextStyle poppins(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color color = Colors.white,
  double? height,
}) =>
    GoogleFonts.poppins(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
    );
