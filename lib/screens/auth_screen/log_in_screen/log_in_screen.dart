// ignore_for_file: deprecated_member_use

import 'package:healthmini/screens/auth_screen/log_in_screen/desktop_log_in_view.dart';
import 'package:healthmini/screens/home_screen/view/mobile_home_view.dart';
import 'package:healthmini/screens/home_screen/view/tablet_home_view.dart';
import 'package:healthmini/utils/general_imports.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  TextEditingController emailCrt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (screenWidth <= 650) {
              return const MobileHomeView();
            } else if (screenWidth > 650 && screenWidth <= 1024) {
              return const TabletHomeView();
            } else {
              return DesktopLoginView(emailCrt: emailCrt);
            }
          },
        ),
      ),
    );
  }
}
