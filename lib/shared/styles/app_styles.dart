import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  // Colors
  static const Color primaryColor = Color(0xFFff6a00);
  static const Color secondaryColor = Color(0xFF285EBE);
  static const Color textColor = Color(0xFF212121);
  static const Color subtitleColor = Color(0xFF8B8B8B);
  static const Color dangerColor = Color(0xFFF33535);

  // Fonts
  static const String headingFontFamily = 'Nunito';
  static const String textFontFamily = 'Inter';

  // Text Styles
  static TextStyle headingTextStyle({
    double? fontSize,
    FontWeight fontWeight = FontWeight.bold,
    Color color = AppStyles.textColor,
  }) {
    return GoogleFonts.nunito(
      fontSize: fontSize != null ? fontSize : 20.0,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle regularTextStyle(
      {double fontSize = 14.0,
      Color color = AppStyles.textColor,
      FontWeight weight = FontWeight.normal}) {
    return GoogleFonts.nunitoSans(
      fontSize: fontSize,
      fontWeight: weight,
      color: color,
    );
  }

  static TextStyle subtitleTextStyle(
      {double fontSize = 11.0,
      Color color = AppStyles.subtitleColor,
      FontWeight weight = FontWeight.normal,
      TextDecoration? decoration}) {
    return GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: weight,
        color: color,
        decoration: decoration,
        decorationColor: color);
  }

// Add more icons as needed using Iconsax library
}
