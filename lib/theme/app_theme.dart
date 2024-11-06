import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF5EC570);
  static const Color accentColor = Color(0xFF1C7EEB);
  static const Color textColor = Color(0xFF212121);
  static const Color secondaryTextColor = Color(0xFF262E2E);
  static const Color backgroundColor = Color(0xFFFFFFFF);

  static ThemeData get theme => ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: GoogleFonts.montserratTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: backgroundColor,
          elevation: 0,
          titleTextStyle: GoogleFonts.montserrat(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
