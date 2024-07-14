import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthmini/widgets/button_widget.dart';
import 'package:lottie/lottie.dart';

import 'const/colors.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (screenWidth <= 650) {
              return const MobileHomeView();
            } else if (screenWidth > 650 && screenWidth <= 1024) {
              return const TabletHomeView();
            } else {
              return const DesktopHomeView();
            }
          },
        ),
      ),
    );
  }
}

class MobileHomeView extends StatelessWidget {
  const MobileHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        AnimatedPositioned(
            duration: const Duration(microseconds: 500),
            curve: Curves.easeInOut,
            left: 0,
            bottom: -1,
            child: SvgPicture.asset(
              'svg/blob-haikei.svg',
              height: 250,
              colorFilter:
                  ColorFilter.mode(AppColors.appColors50, BlendMode.srcIn),
            )),
        AnimatedPositioned(
            duration: const Duration(microseconds: 500),
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
            left: -20,
            bottom: -52,
            child: Lottie.asset('lottie/ani_2.json',
                height: 400)),
        Positioned(
            left: 30,
            top: 10,
            child: Row(
              children: [
                Text(
                  "Health",
                  style: GoogleFonts.dosis(
                    textStyle: TextStyle(
                        color: AppColors.appColors,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                Text(
                  "mini",
                  style: GoogleFonts.dosis(
                    textStyle: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
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
                        const PopupMenuItem(child: Text("English")),
                      ];
                    },
                  );
                },
                icon: const Icon(Icons.translate))),
        AnimatedPositioned(
            duration: const Duration(microseconds: 500),
            curve: Curves.easeInOut,
            top: 60,
            right: 30,
            left: 30,
            child: Column(
              children: [
                Text("HealthMini: Advanced Health Analytics at Your Fingertips",
                    style: GoogleFonts.dosis(
                      textStyle: TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Text(
                    "HealthMini predicts diseases from your symptoms, provides medication advice, connects you with top local doctors, and alerts you to potential pandemics in your area.",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    )),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      text: 'Get started',
                      btnColor: Colors.white,
                      borderWidth: 2,
                      textColor: AppColors.appColors,
                      onTab: () => Navigator.pushNamed(context, 'home'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ButtonWidget(
                      onTab: () => Navigator.pushNamed(context, 'about'),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}

class TabletHomeView extends StatelessWidget {
  const TabletHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.topLeft,
      children: [
        AnimatedPositioned(
            duration: const Duration(microseconds: 500),
            curve: Curves.easeInOut,
            left: 0,
            bottom: -1,
            child: SvgPicture.asset(
              'svg/blob-haikei.svg',
              height: 320,
              colorFilter:
              ColorFilter.mode(AppColors.appColors50, BlendMode.srcIn),
            )),
        AnimatedPositioned(
            duration: const Duration(microseconds: 500),
            curve: Curves.easeInOut,
            right: -1,
            top: -1,
            child: SvgPicture.asset(
              'svg/blob-haikei_2.svg',
              height: screenWidth / 2.2,
              colorFilter:
              ColorFilter.mode(AppColors.appColors50, BlendMode.srcIn),
            )),
        Positioned(
            left: -30,
            bottom: -58,
            child: Lottie.asset('lottie/ani_2.json',
                height: 450)),
        Positioned(
            left: 50, // Adjusted for tablet view
            top: 20, // Adjusted for tablet view
            child: Row(
              children: [
                Text(
                  "Health",
                  style: GoogleFonts.dosis(
                    textStyle: TextStyle(
                        color: AppColors.appColors,
                        fontWeight: FontWeight.bold,
                        fontSize: 30), // Adjusted for tablet view
                  ),
                ),
                Text(
                  "mini",
                  style: GoogleFonts.dosis(
                    textStyle: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30), // Adjusted for tablet view
                  ),
                ),
              ],
            )),
        Positioned(
            right: 10, // Adjusted for tablet view
            top: 10, // Adjusted for tablet view
            child: IconButton(
                onPressed: () {
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(child: Text("English")),
                      ];
                    },
                  );
                },
                icon: const Icon(Icons.translate))),
        AnimatedPositioned(
            duration: const Duration(microseconds: 500),
            curve: Curves.easeInOut,
            top: 100, // Adjusted for tablet view
            right: 50, // Adjusted for tablet view
            left: 50, // Adjusted for tablet view
            child: Column(
              children: [
                Text("HealthMini: Advanced Health Analytics at Your Fingertips",
                    textAlign: TextAlign.center, // Center align for better UI
                    style: GoogleFonts.dosis(
                      textStyle: TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 40), // Adjusted for tablet view
                    )),
                const SizedBox(
                  height: 30, // Adjusted for tablet view
                ),
                Text(
                    "HealthMini predicts diseases from your symptoms, provides medication advice, connects you with top local doctors, and alerts you to potential pandemics in your area.",
                    textAlign: TextAlign.center, // Center align for better UI
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 20), // Adjusted for tablet view
                    )),
                const SizedBox(height: 60), // Adjusted for tablet view
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      text: 'Get started',
                      btnColor: Colors.white,
                      borderWidth: 2,
                      textColor: AppColors.appColors,
                      onTab: () => Navigator.pushNamed(context, 'home'),
                    ),
                    const SizedBox(
                      width: 30, // Adjusted for tablet view
                    ),
                    ButtonWidget(
                      onTab: () => Navigator.pushNamed(context, 'about'),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}

class DesktopHomeView extends StatelessWidget {
  const DesktopHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.topLeft,
      children: [
        AnimatedPositioned(
          duration: const Duration(microseconds: 500),
          curve: Curves.easeInOut,
          left: 0,
          bottom: -1,
          child: SvgPicture.asset(
            'svg/blob-haikei.svg',
            height: screenWidth/3, // Keep as is for desktop view
            colorFilter:
            ColorFilter.mode(AppColors.appColors50, BlendMode.srcIn),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(microseconds: 500),
          curve: Curves.easeInOut,
          right: -1,
          top: -1,
          child: SvgPicture.asset(
            'svg/blob-haikei_2.svg',
            height: 400, // Keep as is for desktop view
            colorFilter:
            ColorFilter.mode(AppColors.appColors50, BlendMode.srcIn),
          ),
        ),
        Positioned(
          left: -screenWidth/30, // Keep as is for desktop view
          bottom: -screenWidth/16, // Keep as is for desktop view
          child: Lottie.asset('lottie/ani_2.json', height: screenWidth/2.1), // Keep as is for desktop view
        ),
        Positioned(
          left: 70, // Keep as is for desktop view
          top: 30, // Keep as is for desktop view
          child: Row(
            children: [
              Text(
                "Health",
                style: GoogleFonts.dosis(
                  textStyle: TextStyle(
                    color: AppColors.appColors,
                    fontWeight: FontWeight.bold,
                    fontSize: 40, // Keep as is for desktop view
                  ),
                ),
              ),
              Text(
                "mini",
                style: GoogleFonts.dosis(
                  textStyle: TextStyle(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 40, // Keep as is for desktop view
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 20, // Keep as is for desktop view
          top: 20, // Keep as is for desktop view
          child: IconButton(
            onPressed: () {
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(child: Text("English")),
                  ];
                },
              );
            },
            icon: const Icon(Icons.translate, size: 30), // Keep as is for desktop view
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(microseconds: 500),
          curve: Curves.easeInOut,
          top: 150, // Adjusted for desktop view
          right: 70, // Adjusted for desktop view
          left: screenWidth/3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end, // Align to right
            children: [
              Text(
                "HealthMini: Advanced Health Analytics at Your Fingertips",
                textAlign: TextAlign.left, // Right align text
                style: GoogleFonts.dosis(
                  textStyle: TextStyle(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 50, // Adjusted for desktop view
                  ),
                ),
              ),
              const SizedBox(
                height: 40, // Adjusted for desktop view
              ),
              Text(
                "HealthMini predicts diseases from your symptoms, provides medication advice, connects you with top local doctors, and alerts you to potential pandemics in your area.",
                textAlign: TextAlign.left, // Right align text
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 25, // Adjusted for desktop view
                  ),
                ),
              ),
              const SizedBox(height: 80), // Adjusted for desktop view
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Align buttons to right
                children: [
                  ButtonWidget(
                    text: 'Get started',
                    btnColor: Colors.white,
                    borderWidth: 2,
                    textColor: AppColors.appColors,
                    onTab: () => Navigator.pushNamed(context, 'home'),
                  ),
                  const SizedBox(
                    width: 40, // Adjusted for desktop view
                  ),
                  ButtonWidget(
                    onTab: () => Navigator.pushNamed(context, 'about'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}


