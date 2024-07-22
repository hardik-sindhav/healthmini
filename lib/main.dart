import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:healthmini/provider/chat_provider.dart';
import 'package:healthmini/provider/symptoms_list_provider.dart';
import 'package:healthmini/screens/about_screen.dart';
import 'package:healthmini/screens/chat_screen/chat_screen.dart';
import 'package:healthmini/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAV3CFoBwNcVPDxusRL8asSqdLZOuI5iPg",
          appId: "1:976825689261:web:51639f063e9b0aeb231224",
          messagingSenderId: "976825689261",
          projectId: "healthmini-cea05",
          measurementId: "G-NR1FWLVSVW"));
  configureApp();
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
    ],
    child: MyApp(),
  ));
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
        '/': (context) => ChatScreen(),
        'home': (context) => HomeScreen(),
        'about': (context) => AboutScreen(),
      },
    );
  }
}
