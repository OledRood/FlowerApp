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

  void hideCurrentSnackBar() {
    scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  }
}
