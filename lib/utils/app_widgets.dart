import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_styles.dart';

// sanckbar
showSnackBar({
  required String message,
  required BuildContext context,
  bool isSuccess = false,
  int duration = 3,
}) {
  SnackBar snackBar = SnackBar(
    margin: const EdgeInsets.only(bottom: 30),
    content: Text(
      message,
      style: AppStyle.helvetica400White.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: isSuccess ? AppColors.black0 : AppColors.white,
        letterSpacing: .03,
      ),
    ),
    backgroundColor: isSuccess ? AppColors.green : AppColors.red,
    duration: Duration(
      seconds: duration,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
