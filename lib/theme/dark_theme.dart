import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

final _base = ThemeData.dark();
final darkTheme = _base.copyWith(
  colorScheme: _base.colorScheme.copyWith(
    primary: AppColors.primaryYellow, // Основной цвет
    secondary: AppColors.primaryYellow, // Вторичный цвет
  ),
  focusColor: AppColors.primaryYellow,
  scaffoldBackgroundColor: Colors.black,
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(AppColors.button),
      foregroundColor: WidgetStatePropertyAll(Colors.black),
    ),
  ),
  textTheme: _base.textTheme.copyWith(
    //Заголовок на главной странице
    headlineLarge: const TextStyle(
        fontSize: 34, fontWeight: FontWeight.w800, color: AppColors.white70),
    //Имя растения
    headlineMedium: const TextStyle(
        fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.white70),
    // Имя растения ошибка
    titleMedium: const TextStyle(
        fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.errorsRed),
    //Подпись даты
    headlineSmall: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.white80),

    labelMedium: const TextStyle(
        fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.white100),

    titleLarge: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: AppColors.white100,
    ),
//TextButton без фона
    labelSmall: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryYellow),
    // labelLarge: const TextStyle(
    //   fontSize: 16,
    //   fontWeight: FontWeight.w600,
    //   color: AppColors.button,
    // ),
  ),
);
