import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyle {
  //white-500-16
  static TextStyle get helvetica500White {
    return const TextStyle(
      fontSize: 16,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    );
  }

  //white-400-16
  static TextStyle get helvetica400White {
    return const TextStyle(
      fontSize: 16,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    );
  }

  //white-700-24
  static TextStyle get helvetica700White {
    return const TextStyle(
      fontSize: 24,
      color: AppColors.white,
      fontWeight: FontWeight.w700,
    );
  }

  //white-500-18
  static TextStyle get proDisplay500 {
    return const TextStyle(
      fontSize: 18,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    );
  }
}
