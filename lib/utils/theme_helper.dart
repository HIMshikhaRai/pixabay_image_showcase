import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeHelper {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    textTheme: GoogleFonts.latoTextTheme(const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(fontSize: 16, color: Colors.black),
      titleSmall: TextStyle(fontSize: 14, color: Colors.black),
    )),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
    snackBarTheme: const SnackBarThemeData(
        contentTextStyle: TextStyle(color: Colors.black)),
    /*appBarTheme: const AppBarTheme(
          color: Color(0xff5927e5),
          titleTextStyle: TextStyle(fontSize: 18),
          centerTitle: true)*/
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    textTheme: GoogleFonts.latoTextTheme(const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(fontSize: 16, color: Colors.black),
      titleSmall: TextStyle(fontSize: 14, color: Colors.black),
    )),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
    snackBarTheme: const SnackBarThemeData(
        contentTextStyle: TextStyle(color: Colors.black)),
    /*appBarTheme: const AppBarTheme(
          color: Color(0xff5927e5),
          titleTextStyle: TextStyle(fontSize: 18),
          centerTitle: true)*/
  );
}
