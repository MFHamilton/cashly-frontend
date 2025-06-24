import 'package:cashly/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextTheme {
  static TextTheme get lightTextTheme => GoogleFonts.robotoCondensedTextTheme().copyWith(
    bodyLarge: GoogleFonts.robotoCondensed(
      fontSize: 16,
      fontWeight: FontWeight.w400, // Regular
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.robotoCondensed(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );
}