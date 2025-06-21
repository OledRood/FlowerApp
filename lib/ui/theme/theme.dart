import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.black),
  );
}

class AppColors {
  const AppColors._();

  static const white70 = Colors.white70;
  static const white100 = Colors.white;
  static const white80 = Color.fromRGBO(255, 255, 255, 0.80);
  static const black = Colors.black;
  static const greyContainer = Color.fromRGBO(191, 191, 191, 0.10);
  static const button = Color.fromRGBO(255, 205, 40, 1);
  static const primaryYellow = Color.fromRGBO(255, 205, 40, 1);
  static const errorsRed = Colors.red;
}




extension AppThemeX on ThemeData{
    ThemeData applyApp() {
    return copyWith(
      colorScheme: colorScheme.copyWith(
        primary: AppColors.primaryYellow,
        secondary: AppColors.primaryYellow,
      ),
      textTheme: textTheme.apply(
        bodyColor: AppColors.white100,
        displayColor: AppColors.white100,
      ),
      scaffoldBackgroundColor: AppColors.black,
      focusColor: AppColors.primaryYellow,
    );
  }

  ButtonStyle get newButtonStyle => ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(colorScheme.primary),

  );
}