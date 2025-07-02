import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/theme/dark_theme.dart';

extension ThemeExtension on BuildContext{
  ThemeData get theme =>  Theme.of(this);
}


extension ThemeStyleExtension on ThemeData{
  TextStyle get headLine => textTheme.headlineLarge!;
  TextStyle get flowerName => textTheme.headlineMedium!;
  TextStyle get flowerNameError => textTheme.titleMedium!;
  TextStyle get date => textTheme.headlineSmall!;
  TextStyle get button => textTheme.labelLarge!;
  //Заголовки для add_flower_page
  TextStyle get label => textTheme.labelMedium!;
  TextStyle get title => textTheme.titleLarge!;
  TextStyle get textButtonWithoutBackground => textTheme.labelSmall!;
  TextStyle get unActiveTextButton => textTheme.labelSmall!.copyWith(color: AppColors.greyContainer);
}