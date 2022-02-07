import 'package:flutter/material.dart';

enum AppEnviroments { prod, staging }

class AppColors {
  static const mainColor = Colors.green;
}

class AppThemeData {
  static final ThemeData lightAppTheme = ThemeData(
    canvasColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
    ),
  );
}
