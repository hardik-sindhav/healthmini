import 'package:healthmini/utils/general_imports.dart';
import 'package:healthmini/widgets/button_widget.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
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
              return const MobileMainView();
            } else if (screenWidth > 650 && screenWidth <= 1024) {
              return const TabletMainView();
            } else {
              return const DesktopMainView();
            }
          },
        ),
      ),
    );
  }
}

class MobileMainView extends StatelessWidget {
  const MobileMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        AnimatedPositioned(
            duration: const Duration(microseconds: 500),
            curve: Curves.easeInOut,
            left: 0,
            bottom: -1,
            child: SvgPicture.asset(
              'svg/blob-haikei.svg',
              height: 250,
              colorFilter:
                  ColorFilter.mode(AppColors.appColors50, BlendMode.srcIn),
            )),
        AnimatedPositioned(
            duration: const Duration(microseconds: 500),
            curve: Curves.easeInOut,
            right: -1,
            top: -1,
            child: SvgPicture.asset(
              'svg/blob-haikei_2.svg',
              height: MediaQuery.of(context).size.width / 2.2,
              colorFilter:
                  ColorFilter.mode(AppColors.appColors50, BlendMode.srcIn),
            )),
        Positioned(
            left: -20,
            bottom: -52,
            child: Lottie.asset('assets/lottie/ani_1.json',
                frameRate: FrameRate.max, repeat: true, height: 400)),
        Positioned(
            left: 30,
            top: 10,
            child: Row(
              children: [
                Image.asset("assets/images/logo.png", height: 35),
                const SizedBox(width: 5),
                Text(
                  "Health",
                  style: AppTextStyles.boldTextStyles(
                      textColor: AppColors.appColors, fontSize: 25),
                ),
                Text(
                  "mini",
                  style: AppTextStyles.boldTextStyles(
                      textColor: AppColors.blackColor, fontSize: 25),
                ),
              ],
            )),
        AnimatedPositioned(
            duration: const Duration(microseconds: 500),
            curve: Curves.easeInOut,
            top: 60,
            right: 30,
            left: 30,
            child: Column(
              children: [
                Text("HealthMini: Advanced Health Analytics at Your Fingertips",
                    style: AppTextStyles.boldTextStyles(
                        textColor: AppColors.blackColor, fontSize: 35)),
                const SizedBox(height: 20),
                Text(
                    "HealthMini predicts diseases from your symptoms, provides medication advice, connects you with top local doctors, and alerts you to potential pandemics in your area.",
                    style: AppTextStyles.mediumTextStyles(
                        textColor: Colors.black87, fontSize: 18)),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                        text: 'Get started',
                        btnColor: Colors.white,
                        borderWidth: 2,
                        textColor: AppColors.appColors,
                        onTab: () {
                          String? country = SharedPreferencesService()
                              .getString(SharedPreferencesService().countryKey);
                          if (country == null || country == '') {
                            Navigator.pushNamed(context, '/user_location');
                          } else {
                            Navigator.pushNamed(context, '/home');
                          }
                        }),
                    const SizedBox(width: 20),
                    ButtonWidget(
                      onTab: () => Navigator.pushNamed(context, '/about'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AnimatedPositioned(
                  duration: const Duration(microseconds: 500),
                  curve: Curves.easeInOut,
                  bottom: 20,
                  right: 30,
                  left: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildFooterLink(
                          context, 'Privacy Policy', '/privacy_policy'),
                      const SizedBox(width: 5),
                      _buildFooterLink(context, 'Terms & Conditions', '/terms'),
                      const SizedBox(width: 5),
                      _buildFooterLink(
                          context, 'Refund Policy', '/refund_policy'),
                      const SizedBox(width: 5),
                      _buildFooterLink(context, 'Contact Us', '/contact'),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }
}

class TabletMainView extends StatelessWidget {
  const TabletMainView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.topLeft,
      children: [
        AnimatedPositioned(
            duration: const Duration(microseconds: 500),
            curve: Curves.easeInOut,
            left: 0,
            bottom: -1,
            child: SvgPicture.asset(
              'svg/blob-haikei.svg',
              height: 320,
              colorFilter:
                  ColorFilter.mode(AppColors.appColors50, BlendMode.srcIn),
            )),
        AnimatedPositioned(
            duration: const Duration(microseconds: 500),
            curve: Curves.easeInOut,
            right: -1,
            top: -1,
            child: SvgPicture.asset(
              'svg/blob-haikei_2.svg',
              height: screenWidth / 2.2,
              colorFilter:
                  ColorFilter.mode(AppColors.appColors50, BlendMode.srcIn),
            )),
        Positioned(
            left: -30,
            bottom: -58,
            child: Lottie.asset('assets/lottie/ani_1.json',
                height: 450, frameRate: FrameRate.max, repeat: true)),
        Positioned(
            left: 50,
            top: 20,
            child: Row(
              children: [
                Image.asset("assets/images/logo.png", height: 40),
                const SizedBox(width: 8),
                Text(
                  "Health",
                  style: AppTextStyles.boldTextStyles(
                      textColor: AppColors.appColors, fontSize: 30),
                ),
                Text(
                  "mini",
                  style: AppTextStyles.boldTextStyles(
                      textColor: AppColors.blackColor, fontSize: 30),
                ),
              ],
            )),
        AnimatedPositioned(
            duration: const Duration(microseconds: 500),
            curve: Curves.easeInOut,
            top: 100,
            right: 50,
            left: 50,
            child: Column(
              children: [
                Text(
                  "HealthMini: Advanced Health Analytics at Your Fingertips",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.boldTextStyles(
                      textColor: AppColors.blackColor, fontSize: 40),
                ),
                const SizedBox(height: 30),
                Text(
                  "HealthMini predicts diseases from your symptoms, provides medication advice, connects you with top local doctors, and alerts you to potential pandemics in your area.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.semiBoldTextStyles(
                      textColor: Colors.black87, fontSize: 20),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                        text: 'Get started',
                        btnColor: Colors.white,
                        borderWidth: 2,
                        textColor: AppColors.appColors,
                        onTab: () {
                          String? country = SharedPreferencesService()
                              .getString(SharedPreferencesService().countryKey);
                          if (country == null || country == '') {
                            Navigator.pushNamed(context, '/user_location');
                          } else {
                            Navigator.pushNamed(context, '/home');
                          }
                        }),
                    const SizedBox(width: 30),
                    ButtonWidget(
                      onTab: () => Navigator.pushNamed(context, '/about'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            )),
        Positioned(
          top: 20,
          left: 70,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/privacy_policy'),
                child: Text(
                  'Privacy Policy',
                  style: AppTextStyles.mediumTextStyles(
                      textColor: Colors.black87, fontSize: 12),
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/terms'),
                child: Text(
                  'Terms & Conditions',
                  style: AppTextStyles.mediumTextStyles(
                      textColor: Colors.black87, fontSize: 12),
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/refund_policy'),
                child: Text(
                  'Refund Policy',
                  style: AppTextStyles.mediumTextStyles(
                      textColor: Colors.black87, fontSize: 12),
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/contact'),
                child: Text(
                  'Contact Us',
                  style: AppTextStyles.mediumTextStyles(
                      textColor: Colors.black87, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildFooterLink(BuildContext context, String text, String route) {
  return TextButton(
    onPressed: () => Navigator.pushNamed(context, route),
    child: Text(
      text,
      style: AppTextStyles.mediumTextStyles(
        textColor: AppColors.appColors,
        fontSize: 14,
      ),
    ),
  );
}

class DesktopMainView extends StatelessWidget {
  const DesktopMainView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.topLeft,
      children: [
        AnimatedPositioned(
          duration: const Duration(microseconds: 500),
          curve: Curves.easeInOut,
          left: 0,
          bottom: -1,
          child: SvgPicture.asset(
            'svg/blob-haikei.svg',
            height: screenWidth / 3,
            colorFilter:
                ColorFilter.mode(AppColors.appColors50, BlendMode.srcIn),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(microseconds: 500),
          curve: Curves.easeInOut,
          right: -1,
          top: -1,
          child: SvgPicture.asset(
            'svg/blob-haikei_2.svg',
            height: 400,
            colorFilter:
                ColorFilter.mode(AppColors.appColors50, BlendMode.srcIn),
          ),
        ),
        Positioned(
          left: -screenWidth / 30,
          bottom: -screenWidth / 16,
          child: Lottie.asset('assets/lottie/ani_1.json',
              height: screenWidth / 2.1,
              frameRate: FrameRate.max,
              repeat: true),
        ),
        Positioned(
          left: 70,
          top: 30,
          child: Row(
            children: [
              Image.asset("assets/images/logo.png", height: 50),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Health",
                style: AppTextStyles.boldTextStyles(
                  textColor: AppColors.appColors,
                  fontSize: 40,
                ),
              ),
              Text(
                "mini",
                style: AppTextStyles.boldTextStyles(
                  textColor: AppColors.blackColor,
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(microseconds: 500),
          curve: Curves.easeInOut,
          top: 150,
          right: 70,
          left: screenWidth / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "HealthMini: Advanced Health Analytics at Your Fingertips",
                textAlign: TextAlign.left,
                style: AppTextStyles.boldTextStyles(
                  textColor: AppColors.blackColor,
                  fontSize: 50,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "HealthMini predicts diseases from your symptoms, provides medication advice, connects you with top local doctors, and alerts you to potential pandemics in your area.",
                textAlign: TextAlign.left,
                style: AppTextStyles.mediumTextStyles(
                  textColor: Colors.black87,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonWidget(
                      text: 'Get started',
                      btnColor: Colors.white,
                      borderWidth: 2,
                      textColor: AppColors.appColors,
                      onTab: () {
                        String? country = SharedPreferencesService()
                            .getString(SharedPreferencesService().countryKey);
                        if (country == null || country == '') {
                          Navigator.pushNamed(context, '/user_location');
                        } else {
                          Navigator.pushNamed(context, '/home');
                        }
                      }),
                  const SizedBox(
                    width: 40,
                  ),
                  ButtonWidget(
                    onTab: () => Navigator.pushNamed(context, '/about'),
                  ),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          left: 70,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/privacy_policy'),
                child: Text(
                  'Privacy Policy',
                  style: AppTextStyles.mediumTextStyles(
                      textColor: Colors.black87, fontSize: 16),
                ),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/terms'),
                child: Text(
                  'Terms & Conditions',
                  style: AppTextStyles.mediumTextStyles(
                      textColor: Colors.black87, fontSize: 16),
                ),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/contact'),
                child: Text(
                  'Contact Us',
                  style: AppTextStyles.mediumTextStyles(
                      textColor: Colors.black87, fontSize: 16),
                ),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/refund_policy'),
                child: Text(
                  'Refund Policy',
                  style: AppTextStyles.mediumTextStyles(
                      textColor: Colors.black87, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
