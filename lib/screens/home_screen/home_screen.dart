import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthmini/screens/home_screen/view/mobile_home_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isLoad = true;

  String? _currentSvg = '';
  String? _currentSvg2 = '';
  String? _currentSvg3 = '';
  Timer? _timer;
  Timer? _timer2;
  Timer? _timer3;
  final Random _random = Random();
  final Random _random2 = Random();
  final Random _random3 = Random();

  @override
  void initState() {
    super.initState();
    _currentSvg = svgList[_random.nextInt(svgList.length)];
    _currentSvg2 = svgList[_random2.nextInt(svgList.length)];
    _currentSvg3 = svgList[_random3.nextInt(svgList.length)];
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: _random.nextInt(6) + 5), (timer) {
      setState(() {
        _currentSvg = svgList[_random.nextInt(svgList.length)];
      });
    });

    _timer2 =
        Timer.periodic(Duration(seconds: _random2.nextInt(6) + 5), (timer) {
          setState(() {
            _currentSvg2 = svgList[_random2.nextInt(svgList.length)];
          });
        });

    _timer3 =
        Timer.periodic(Duration(seconds: _random3.nextInt(6) + 5), (timer) {
          setState(() {
            _currentSvg3 = svgList[_random3.nextInt(svgList.length)];
          });
        });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer2?.cancel();
    super.dispose();
  }


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
                return const MobileHomeView();
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
