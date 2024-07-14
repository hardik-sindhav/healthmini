import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthmini/const/colors.dart';
import 'package:healthmini/widgets/button_widget.dart';
import 'package:lottie/lottie.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 30;
    double minFontSize = 28;
    double padding = MediaQuery.of(context).size.width / 60;
    double minPadding = 20;
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonLeftPadding = 0;
    double buttonRightPadding = 0;
    double buttonTopPadding = 400;
    double titleRightPadding = 20;
    double titleTopPadding = 400;
    double titleLeftPadding = 25;
    double size = MediaQuery.of(context).size.width;
    

    if (screenWidth <= 650) {
      titleRightPadding = size / 20;
      titleTopPadding = size/5;
      titleLeftPadding = size / 20;
    } else if (screenWidth > 650 && screenWidth <= 1024) {
      buttonTopPadding = size / 1.8;
      buttonRightPadding = size / 20;
      titleTopPadding = size/5;
      titleRightPadding = size / 20;
      titleLeftPadding = size/3.3;

    } else {
      buttonRightPadding = size / 20;
      buttonTopPadding = 600;
      titleRightPadding = size / 15;
      titleLeftPadding = size/1.87;
      titleTopPadding = size/5;
    }

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            AnimatedPositioned(
                duration: Duration(microseconds: 500),
                curve: Curves.easeInOut,
                left: 0,
                bottom: -1,
                child: SvgPicture.asset(
                  'svg/blob-haikei.svg',
                  height: MediaQuery.of(context).size.width / 2.2,
                  colorFilter:
                      ColorFilter.mode(AppColors.appColors50, BlendMode.srcIn),
                )),
            AnimatedPositioned(
                duration: Duration(microseconds: 500),
                curve: Curves.easeInOut,
                right: -1,
                top: -1,
                child: SvgPicture.asset(
                  'svg/blob-haikei_2.svg',
                  height: MediaQuery.of(context).size.width / 2.2,
                  colorFilter:
                      ColorFilter.mode(AppColors.appColors50, BlendMode.srcIn),
                )),
            Positioned(
                left: -MediaQuery.of(context).size.width / 30,
                bottom: -MediaQuery.of(context).size.width / 12,
                child: Lottie.asset('lottie/ani_2.json',
                    height: MediaQuery.of(context).size.width / 1.6)),
            Positioned(
                left: padding < minPadding ? minPadding + 10 : padding + 10,
                top: padding < minPadding ? minPadding : padding,
                child: Row(
                  children: [
                    Text(
                      "Health",
                      style: GoogleFonts.dosis(
                        textStyle: TextStyle(
                            color: AppColors.appColors,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize < minFontSize
                                ? minFontSize
                                : fontSize),
                      ),
                    ),
                    Text(
                      "mini  ${MediaQuery.of(context).size.width.toStringAsFixed(2)}",
                      style: GoogleFonts.dosis(
                        textStyle: TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize < minFontSize
                                ? minFontSize
                                : fontSize),
                      ),
                    ),
                  ],
                )),
            AnimatedPositioned(
                duration: Duration(microseconds: 500),
                curve: Curves.easeInOut,
                top: buttonTopPadding,
                right: buttonRightPadding,
                left: buttonLeftPadding,
                child: Row(
                  mainAxisAlignment: size < 650
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.end,
                  children: [
                    ButtonWidget(
                      text: 'Get started',
                      btnColor: Colors.white,
                      borderWidth: 2,
                      textColor: AppColors.appColors,
                      onTab: () => Navigator.pushNamed(context, 'home'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ButtonWidget(
                      onTab: () => Navigator.pushNamed(context, 'about'),

                    ),
                  ],
                )),
            Positioned(
                right: 2,
                top: 2,
                child: IconButton(
                    onPressed: () {
                      PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(child: Text("English")),
                          ];
                        },
                      );
                    },
                    icon: Icon(Icons.translate))),
            AnimatedPositioned(
                duration: Duration(microseconds: 500),
                curve: Curves.easeInOut,
              top: titleTopPadding,
                right: titleRightPadding,
                left: titleLeftPadding,
                child: Column(
                  children: [
                    Text(
                        "HealthMini: Advanced Health Analytics at Your Fingertips",
                      style : GoogleFonts.dosis( textStyle : TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize < minFontSize
                              ? minFontSize
                              : fontSize > 35 ? 35 : fontSize),
                      )
                    ),
                    SizedBox(height: 20,),
                    Text(
                        "HealthMini predicts diseases from your symptoms, provides medication advice, connects you with top local doctors, and alerts you to potential pandemics in your area.",
                        style : GoogleFonts.lato( textStyle : TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: fontSize < minFontSize
                                ? minFontSize - 13
                                : fontSize > 18 ? 18 : fontSize-15),
                        )
                    )

                  ],
                )),

          ],
        ),
      ),
    );
  }
}
