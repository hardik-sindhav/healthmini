import 'package:flutter/material.dart';
import 'package:healthmini/const/colors.dart';

class AppTextStyles {
  static TextStyle normalTextStyles({double? fontSize, Color? textColor}) {
    return TextStyle(
        color: textColor ?? AppColors.blackColor,
        fontWeight: FontWeight.w400,
        fontSize: fontSize ?? 16,
        fontFamily: "Dosis");
  }

  static TextStyle mediumTextStyles({double? fontSize, Color? textColor}) {
    return TextStyle(
        color: textColor ?? AppColors.blackColor,
        fontWeight: FontWeight.w500,
        fontSize: fontSize ?? 35,
        fontFamily: "Dosis");
  }

  static TextStyle semiBoldTextStyles({double? fontSize, Color? textColor}) {
    return TextStyle(
        color: textColor ?? AppColors.blackColor,
        fontWeight: FontWeight.w600,
        fontSize: fontSize ?? 35,
        fontFamily: "Dosis");
  }

  static TextStyle boldTextStyles({double? fontSize, Color? textColor}) {
    return TextStyle(
        color: textColor ?? AppColors.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: fontSize ?? 35,
        fontFamily: "Dosis");
  }
}
