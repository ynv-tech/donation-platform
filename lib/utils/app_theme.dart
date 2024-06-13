import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static AppTheme? _appTheme;

  factory AppTheme() {
    _appTheme = AppTheme._internal();
    return _appTheme!;
  }

  AppTheme._internal();

  /// return light mode theme
  ThemeData lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      primaryColor: AppColors.white,
      brightness: Brightness.light,
      hoverColor: AppColors.tranparent,
      scrollbarTheme: ScrollbarThemeData(
        thickness: MaterialStateProperty.all(7.5),
        trackColor: MaterialStateProperty.all(
          AppColors.tranparent,
        ),
        trackBorderColor: MaterialStateProperty.all(
          AppColors.tranparent,
        ),
      ),
    );
  }
}
