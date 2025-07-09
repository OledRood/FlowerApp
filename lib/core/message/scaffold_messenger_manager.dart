import 'package:flowers_app/ui/theme/dark_theme.dart';
import 'package:flutter/material.dart';

class ScaffoldMessengerManager {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: AppColors.errorsRed)),
      backgroundColor: AppColors.greyContainer,
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  void showUpSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: AppColors.white100)),
      backgroundColor: AppColors.errorsRed,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: EdgeInsets.only(
        // Позволяет отобразить сверху
        bottom: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.height - 150,
        left: 20,
        right: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  void hideCurrentSnackBar() {
    scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  }
}
