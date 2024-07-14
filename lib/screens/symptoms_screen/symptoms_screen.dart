import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthmini/screens/home_screen/view/mobile_home_view.dart';
import 'package:healthmini/screens/symptoms_screen/view/symptoms_mobile_view.dart';

class SymptomsScreen extends StatefulWidget {
  const SymptomsScreen({super.key});

  @override
  State<SymptomsScreen> createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (screenWidth <= 650) {
                return const SymptomsMobileView();
              } else if (screenWidth > 650 && screenWidth <= 1024) {
                return  Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }


  List<String> svgList = [
    'assets/svg/svg_shape/shape_1.svg',
    'assets/svg/svg_shape/shape_2.svg',
    'assets/svg/svg_shape/shape_3.svg',
    'assets/svg/svg_shape/shape_4.svg',
    'assets/svg/svg_shape/shape_5.svg',
    'assets/svg/svg_shape/shape_6.svg',
    'assets/svg/svg_shape/shape_7.svg',
    'assets/svg/svg_shape/shape_8.svg',
    'assets/svg/svg_shape/shape_9.svg',
    'assets/svg/svg_shape/shape_10.svg',
    'assets/svg/svg_shape/shape_11.svg',
    'assets/svg/svg_shape/shape_12.svg',
    'assets/svg/svg_shape/shape_13.svg',
    'assets/svg/svg_shape/shape_14.svg'
  ];

}
