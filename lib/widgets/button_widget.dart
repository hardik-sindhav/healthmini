import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthmini/const/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String? text;
  final double? borderWidth;
  final Color? btnColor;
  final Color? textColor;
  final VoidCallback? onTab;

  const ButtonWidget({
    super.key,
    this.text,
    this.borderWidth,
    this.btnColor,
    this.textColor,
    this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth;
    double buttonHeight;
    double buttonMaxHeight = 50;

    if (screenWidth <= 650) {
      // Mobile view
      buttonWidth = screenWidth / 2.5;
      buttonHeight = screenWidth / 10;
    } else if (screenWidth > 650 && screenWidth <= 1024) {
      // Tablet view
      buttonWidth = screenWidth / 3;
      buttonHeight = screenWidth / 15;
    } else {
      // Desktop view
      buttonWidth = screenWidth / 5;
      buttonHeight = screenWidth / 20;
    }

    return InkWell(
      onTap: onTab,
      child: Container(
        alignment: Alignment.center,
        height: buttonHeight > buttonMaxHeight ? buttonMaxHeight : buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: btnColor ?? AppColors.appColors,
          border: Border.all(
            color: AppColors.appColors,
            width: borderWidth ?? 0,
          ),
        ),
        child: Text(
          text ?? "About Us",
          style: GoogleFonts.dosis(
            textStyle: TextStyle(
              fontSize: 18,
              color: textColor ?? AppColors.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
