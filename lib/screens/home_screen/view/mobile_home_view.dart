import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthmini/const/colors.dart';
import 'package:healthmini/widgets/network_image.dart';
import 'package:lottie/lottie.dart';

class MobileHomeView extends StatelessWidget {
  const MobileHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.width / 1.7,
          width: MediaQuery.of(context).size.width / 1.1,
          decoration: BoxDecoration(
              color: AppColors.appColors.withOpacity(0.4),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // NetworkImages(
              //   imageUrl:
              //       'https://i.postimg.cc/XYRbcX1P/brooke-lark-j-UPOXXRNdc-A-unsplash.jpg',
              //   fit: BoxFit.cover,
              // ),

              // Positioned(
              //   bottom: 0,
              //   child: Container(
              //     width: MediaQuery.of(context).size.width / 1.1,
              //     height: 50,
              //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              //     decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //         colors: [
              //           Colors.black.withOpacity(0.60),
              //           Colors.black.withOpacity(0.80),
              //         ],
              //       ),
              //     ),
              //     child: Text(
              //       "To unsync your phone from Google Photos, simply go to your settings and look for the 'Google Photos' tab. From there, you can deselect the",
              //       style: TextStyle(color: Colors.white),
              //       maxLines: 2,
              //       overflow: TextOverflow.ellipsis,
              //     ),
              //   ),
              // ),

              Positioned(
                  bottom: -size / 15,
                  left: -10,
                  child: Lottie.asset('assets/lottie/ani_3.json',
                      height: size / 2)),

              Positioned(
                top: 50,
                right: 15,
                left: size/2.1,
                child: Text(
                  textAlign: TextAlign.left,
                  style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                  ),
                    "Find your disease with just select or enter your symptoms we recommend you best hospital"),
              ),

              Positioned(
                bottom: 15,
                right: 15,
                child: Container(
                    height: 40,
                    width: size / 2.5,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text("Try Free",style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),)),
              ),
              Positioned(
                  top: 15,
                  left: 15,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Row(
                      children: [
                        Icon(
                          Icons.health_and_safety,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Health")
                      ],
                    ),
                  ))
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: const EdgeInsets.only(top: 20),
                height: 320,
                decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    NetworkImages(
                      imageUrl:
                          'https://i.postimg.cc/XYRbcX1P/brooke-lark-j-UPOXXRNdc-A-unsplash.jpg',
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2.2,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.60),
                              Colors.black.withOpacity(0.80),
                            ],
                          ),
                        ),
                        child: Text(
                          "To unsync your phone from Google Photos, simply go to your settings and look for the 'Google Photos' tab. From there, you can deselect the",
                          style: TextStyle(color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 15,
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0.0, end: 0.9),
                              duration: const Duration(milliseconds: 1000),
                              builder: (context, value, _) =>
                                  CircularProgressIndicator(
                                value: value,
                                strokeWidth: 3,
                              ),
                            ),
                            Icon(Icons.play_arrow_rounded),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 15,
                        left: 15,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Row(
                            children: [
                              Icon(
                                Icons.fastfood_outlined,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Racipe")
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.only(top: 20),
                    height: 150,
                    decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        NetworkImages(
                          imageUrl:
                              'https://i.postimg.cc/XYRbcX1P/brooke-lark-j-UPOXXRNdc-A-unsplash.jpg',
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.60),
                                  Colors.black.withOpacity(0.80),
                                ],
                              ),
                            ),
                            child: Text(
                              "To unsync your phone from Google Photos, simply go to your settings and look for the 'Google Photos' tab. From there, you can deselect the",
                              style: TextStyle(color: Colors.white),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 15,
                          child: Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                TweenAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0.0, end: 0.9),
                                  duration: const Duration(milliseconds: 1000),
                                  builder: (context, value, _) =>
                                      CircularProgressIndicator(
                                    value: value,
                                    strokeWidth: 3,
                                  ),
                                ),
                                Icon(Icons.play_arrow_rounded),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            top: 15,
                            left: 15,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.fastfood_outlined,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Racipe")
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.only(top: 20),
                    height: 150,
                    decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        NetworkImages(
                          imageUrl:
                              'https://i.postimg.cc/XYRbcX1P/brooke-lark-j-UPOXXRNdc-A-unsplash.jpg',
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.60),
                                  Colors.black.withOpacity(0.80),
                                ],
                              ),
                            ),
                            child: Text(
                              "To unsync your phone from Google Photos, simply go to your settings and look for the 'Google Photos' tab. From there, you can deselect the",
                              style: TextStyle(color: Colors.white),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 15,
                          child: Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                TweenAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0.0, end: 0.9),
                                  duration: const Duration(milliseconds: 1000),
                                  builder: (context, value, _) =>
                                      CircularProgressIndicator(
                                    value: value,
                                    strokeWidth: 3,
                                  ),
                                ),
                                Icon(Icons.play_arrow_rounded),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            top: 15,
                            left: 15,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.fastfood_outlined,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Racipe")
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
