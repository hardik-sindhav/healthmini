import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthmini/service/shared_preferences_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        String? country = SharedPreferencesService()
            .getString(SharedPreferencesService().countryKey);
        if (country == null || country == '') {
          Navigator.pushNamed(context, '/user_location');
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (route) => true,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            "assets/images/logo.png",
            height: 150,
            width: 150,
          ),
        ),
      ),
    );
  }
}
