import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../const/colors.dart';

class AppTextStyles {

  TextStyle normalTextStyles(){
    return GoogleFonts.dosis(
      textStyle: TextStyle(
          color: AppColors.blackColor,
          fontWeight: FontWeight.bold,
          fontSize: 35),
    );
  }
}