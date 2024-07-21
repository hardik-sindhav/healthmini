import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../const/colors.dart';

class AppTextStyles {

  static TextStyle normalTextStyles({double? fontSize,Color? textColor}){
    return GoogleFonts.dosis(
      textStyle: TextStyle(
          color: textColor??AppColors.blackColor,
          fontWeight: FontWeight.w400,
          fontSize: fontSize??16),
    );
  }

  static TextStyle mediumTextStyles({double? fontSize,Color? textColor}){
    return GoogleFonts.dosis(
      textStyle: TextStyle(
          color: textColor??AppColors.blackColor,
          fontWeight: FontWeight.w500,
          fontSize: fontSize??35),
    );
  }

  static TextStyle semiBoldTextStyles({double? fontSize,Color? textColor}){
    return GoogleFonts.dosis(
      textStyle: TextStyle(
          color: textColor??AppColors.blackColor,
          fontWeight: FontWeight.w600,
          fontSize: fontSize??35),
    );
  }

  static TextStyle boldTextStyles({double? fontSize,Color? textColor}){
    return GoogleFonts.dosis(
      textStyle: TextStyle(
          color: textColor??AppColors.blackColor,
          fontWeight: FontWeight.bold,
          fontSize: fontSize??35),
    );
  }

}