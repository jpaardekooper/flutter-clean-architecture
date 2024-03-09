import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // *****************
  // static colors
  // *****************
  static const Color _lightPrimaryColor = Color(0xFF006783);
  static const Color _lightPrimaryVariantColor = Color(0xffffffff);
  static const Color _lightOnPrimaryColor = Color(0xffffffff);
  static const Color _lightTextColorPrimary = Color(0xFF001f29);

  static final Color _darkPrimaryColor = Colors.blueGrey.shade900;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static final Color _darkOnPrimaryColor = Colors.blueGrey.shade300;
  static const Color _darkTextColorPrimary = Colors.white;

  static const Color _iconColor = Colors.white;

  static const Color _accentColor = Color.fromRGBO(74, 217, 217, 1);

  // *****************
  // Text Style - light
  // *****************
  static const TextStyle _lightHeadingText =
      TextStyle(color: _lightTextColorPrimary, fontFamily: "Figtree", fontSize: 20, fontWeight: FontWeight.bold);

  static const TextStyle _lightBodyText = TextStyle(
    color: _lightTextColorPrimary,
    fontFamily: "Figtree",
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightHeadingText,
    bodyLarge: _lightBodyText,
  );

  // *****************
  // Text Style - dark
  // *****************
  static final TextStyle _darkThemeHeadingTextStyle = _lightHeadingText.copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkThemeBodyeTextStyle = _lightBodyText.copyWith(color: _darkTextColorPrimary);

  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: _darkThemeHeadingTextStyle,
    bodyLarge: _darkThemeBodyeTextStyle,
  );

  // *****************
  // Theme light/dark
  // *****************

  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: _lightPrimaryVariantColor,
      appBarTheme: const AppBarTheme(color: _lightPrimaryColor, iconTheme: IconThemeData(color: _iconColor)),
      colorScheme: ColorScheme.fromSeed(
        seedColor: _lightPrimaryColor,
        secondary: const Color(0xFF4c616b),
        tertiary: const Color(0xFF5c5b7d),
      ),
      textTheme: _lightTextTheme,
      bottomAppBarTheme: const BottomAppBarTheme(color: _lightPrimaryColor));

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: _darkPrimaryColor,
      appBarTheme: AppBarTheme(color: _darkPrimaryColor, iconTheme: const IconThemeData(color: _iconColor)),
      colorScheme: ColorScheme.dark(
        primary: _darkPrimaryColor,
        secondary: _accentColor,
        onPrimary: _darkOnPrimaryColor,
        primaryContainer: _darkPrimaryVariantColor,
      ),
      textTheme: _darkTextTheme,
      bottomAppBarTheme: BottomAppBarTheme(color: _darkPrimaryColor));
}
