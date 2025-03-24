// ignore_for_file: prefer_const_constructors
import 'package:healthmini/pages/refund_policy_page..dart';
import 'package:healthmini/screens/auth_screen/log_in_screen/log_in_screen.dart';
import 'package:healthmini/utils/general_imports.dart';

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
      measurementId: "G-NR1FWLVSVW",
    ),
  );
  configureWebApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SymptomsListProvider>(
        create: (context) => SymptomsListProvider(),
      ),
      ChangeNotifierProvider<ChatProvider>(
        create: (context) => ChatProvider(),
      ),
      ChangeNotifierProvider<ExerciseListProvider>(
        create: (context) => ExerciseListProvider(),
      ),
      ChangeNotifierProvider<RecipeListProvider>(
        create: (context) => RecipeListProvider(),
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthMini',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appColors),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>  LandingScreen(),
        '/home': (context) => HomeScreen(),
        '/about': (context) => AboutUsPage(),
        '/find_symptoms': (context) => SymptomsScreen(),
        '/details_page': (context) => DetailsScreen(),
        '/chat': (context) => ChatScreen(),
        '/exercise_details': (context) => ExerciseDetailView(),
        '/recipe_details': (context) => RecipeDetailView(),
        '/privacy_policy': (context) => PrivacyPolicyPage(),
        '/refund_policy': (context) => RefundPolicyPage(),
        '/contact_page': (context) => ContactUsPage(),
        '/terms_conditions': (context) => TermsConditionsPage(),
        '/reviews': (context) => ReviewsPage(),
        '/user_location': (context) => UserLocationScreen(),
        '/user_profile': (context) => UserProfileSetupScreen(),
        '/statistics': (context) => StatisticsScreen(),
      },
    );
  }
}
