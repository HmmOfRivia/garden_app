import 'package:flutter/material.dart';

enum AppEnviroments { prod, staging }

class AppColors {
  static const mainColor = Colors.green;
  static const successColor = Colors.lightGreen;
  static const failureColor = Colors.red;
}

extension ColorBrightness on Color {
  Color get dark {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness(hsl.lightness - .2).toColor();
  }
}

class AppStyles {
  static TextStyle whiteMedium(double size) => TextStyle(
        fontSize: size,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      );
  static TextStyle whiteRegular(double size) => TextStyle(
        fontSize: size,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      );
  static TextStyle blackMedium(double size) => TextStyle(
        fontSize: size,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      );
  static TextStyle blackRegular(double size) => TextStyle(
        fontSize: size,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      );
}

class AppThemeData {
  static final ThemeData lightAppTheme = ThemeData(
    canvasColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
    ),
  );
}
