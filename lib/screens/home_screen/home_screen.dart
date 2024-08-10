// ignore_for_file: deprecated_member_use

import 'package:healthmini/screens/home_screen/view/mobile_home_view.dart';
import 'package:healthmini/screens/home_screen/view/tablet_home_view.dart';
import 'package:healthmini/utils/general_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoad = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        apiCall();
      },
    );
  }

  void apiCall() {
    Provider.of<ExerciseListProvider>(context, listen: false)
        .getExerciseList(context: context);
    Provider.of<RecipeListProvider>(context, listen: false)
        .getRecipeList(context: context);
  }


  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Are you sure you want to exit the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(), // Exits the app
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: const ResponsiveAppBar(),
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
                  return const TabletHomeView();
                } else {
                  return const DesktopHomeView();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
