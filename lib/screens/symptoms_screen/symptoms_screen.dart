import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthmini/provider/symptoms_list_provider.dart';
import 'package:healthmini/screens/symptoms_screen/view/symptoms_desktop_view.dart';
import 'package:healthmini/screens/symptoms_screen/view/symptoms_mobile_view.dart';
import 'package:healthmini/screens/symptoms_screen/view/symptoms_tablet_view.dart';
import 'package:provider/provider.dart';

class SymptomsScreen extends StatefulWidget {
  const SymptomsScreen({super.key});

  @override
  State<SymptomsScreen> createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(microseconds: 100),
      () => Provider.of<SymptomsListProvider>(context, listen: false)
          .getSymptomsList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Consumer<SymptomsListProvider>(
          builder: (context, symptomsListProvider, child) {
        switch (symptomsListProvider.symptomsListState) {
          case SymptomsListState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case SymptomsListState.loaded:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (screenWidth <= 650) {
                      return SymptomsMobileView(
                          dataList: symptomsListProvider.symptomsList,
                          selectedSymptomsList:
                              symptomsListProvider.selectedSymptomsList);
                    } else if (screenWidth > 650 && screenWidth <= 1024) {
                      return SymptomsTabletView(
                          dataList: symptomsListProvider.symptomsList,
                          selectedSymptomsList:
                              symptomsListProvider.selectedSymptomsList);
                    } else {
                      return SymptomsDesktopView(
                          dataList: symptomsListProvider.symptomsList,
                          selectedSymptomsList:
                              symptomsListProvider.selectedSymptomsList);
                    }
                  },
                ),
              );
          case SymptomsListState.error:
            return Container(
              child: const Text("Error"),
            );
          default:
            return const Center(child: Text('Welcome'));
        }
      }),
    ));
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
