import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:healthmini/screens/about_screen.dart';
import 'package:healthmini/screens/home_screen/home_screen.dart';
import 'package:healthmini/screens/landing_screen.dart';
import 'package:healthmini/screens/symptoms_screen/symptoms_screen.dart';

import 'demo_page.dart';

void main() {
  configureApp();
  runApp(const MyApp());
}

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthmini',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SymptomsScreen(),
        'home': (context) => HomeScreen(),
        'about': (context) => AboutScreen(),
      },
    );
  }
}
