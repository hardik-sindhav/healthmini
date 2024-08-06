// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthmini/const/colors.dart';
import 'package:healthmini/provider/chat_provider.dart';
import 'package:healthmini/provider/exercise_provider.dart';
import 'package:healthmini/provider/recipe_provider.dart';
import 'package:healthmini/provider/symptoms_list_provider.dart';
import 'package:healthmini/screens/landing_screen.dart';
import 'package:healthmini/screens/chat_screen/chat_screen.dart';
import 'package:healthmini/screens/details_screen/details_screen.dart';
import 'package:healthmini/screens/exercise_screen/exercise_details_view.dart';
import 'package:healthmini/screens/home_screen/home_screen.dart';
import 'package:healthmini/screens/landing_screen.dart';
import 'package:healthmini/screens/pages/about_us_page.dart';
import 'package:healthmini/screens/pages/contact_page.dart';
import 'package:healthmini/screens/recipe_screen/recipe_details_view.dart';
import 'package:healthmini/screens/statistics_screen/statistics_screen.dart';
import 'package:healthmini/screens/symptoms_screen/symptoms_screen.dart';
import 'package:healthmini/screens/user_location_screen/user_location_screen.dart';
import 'package:healthmini/service/shared_preferences_service.dart';
import 'package:provider/provider.dart';
import 'package:healthmini/utils/web_config.dart'
if (dart.library.html) 'package:healthmini/utils/web_config.dart'
if (dart.library.io) 'package:healthmini/utils/web_config_stub.dart';

import 'screens/pages/privacy_policy_page.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService().init();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAV3CFoBwNcVPDxusRL8asSqdLZOuI5iPg",
          appId: "1:976825689261:web:51639f063e9b0aeb231224",
          messagingSenderId: "976825689261",
          projectId: "healthmini-cea05",
          measurementId: "G-NR1FWLVSVW"));
  configureWebApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SymptomsListProvider>(
        create: (context) {
          return SymptomsListProvider();
        },
      ),
      ChangeNotifierProvider<ChatProvider>(
        create: (context) {
          return ChatProvider();
        },
      ),
      ChangeNotifierProvider<ExerciseListProvider>(
        create: (context) {
          return ExerciseListProvider();
        },
      ),
      ChangeNotifierProvider<RecipeListProvider>(
        create: (context) {
          return RecipeListProvider();
        },
      ),
    ],
    child: MyApp(),
  ));
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
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appColors),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingScreen(),
        '/home': (context) => HomeScreen(),
        '/about': (context) => AboutUsPage(),
        '/find_symptoms': (context) => SymptomsScreen(),
        '/details_page': (context) => DetailsScreen(),
        '/chat': (context) => ChatScreen(),
        '/exercise_details': (context) => ExerciseDetailView(),
        '/recipe_details': (context) => RecipeDetailView(),
        '/privacy_policy': (context) => PrivacyPolicyPage(),
        '/contact_page': (context) => ContactUsPage(),
        '/user_location': (context) => UserLocationScreen(),
        '/statistics': (context) => StatisticsScreen(),
      },
    );
  }
}
