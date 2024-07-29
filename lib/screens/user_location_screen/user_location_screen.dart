import 'package:flutter/material.dart';
import 'package:healthmini/screens/user_location_screen/view/user_location_mobile_view.dart';

class UserLocationScreen extends StatelessWidget {
  const UserLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (screenWidth <= 650) {
                  return UserLocationMobileView();
                } else if (screenWidth > 650 && screenWidth <= 1024) {
                  return UserLocationMobileView();
                } else {
                  return UserLocationMobileView();
                }
              },
            )));
  }
}
