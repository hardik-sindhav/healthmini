import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthmini/service/shared_preferences_service.dart';
import 'package:healthmini/utils/textstyles.dart';

class UserLocationScreen extends StatefulWidget {
  const UserLocationScreen({super.key});

  @override
  State<UserLocationScreen> createState() => _UserLocationScreenState();
}

class _UserLocationScreenState extends State<UserLocationScreen> {
  String? countryValue, stateValue, cityValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select your location",
          style: AppTextStyles.mediumTextStyles(fontSize: 20),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            // Desktop Layout
            return _buildDesktopLayout(context);
          } else if (constraints.maxWidth > 600) {
            // Tablet Layout
            return _buildTabletLayout(context);
          } else {
            // Mobile Layout
            return _buildMobileLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              "assets/svg/location.svg",
              width: 300,
              height: 300,
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            flex: 2,
            child: _buildForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              "assets/svg/location.svg",
              width: 200,
              height: 200,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: _buildForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/svg/location.svg",
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 20),
          _buildForm(),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Please select your country, state, and city to help us identify disease patterns and alert you of potential pandemics. Your participation is crucial for community health and safety.",
          style: AppTextStyles.normalTextStyles(fontSize: 14),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 20),
        CSCPicker(
          dropdownHeadingStyle: AppTextStyles.semiBoldTextStyles(fontSize: 18),
          dropdownItemStyle: AppTextStyles.mediumTextStyles(fontSize: 16),
          selectedItemStyle: AppTextStyles.mediumTextStyles(fontSize: 16),
          flagState: CountryFlag.DISABLE,
          layout: Layout.vertical,
          onCountryChanged: (value) async {
            await SharedPreferencesService()
                .setString(SharedPreferencesService().countryKey, value);
            setState(() {
              countryValue = value;
            });
          },
          onStateChanged: (value) async {
            await SharedPreferencesService()
                .setString(SharedPreferencesService().stateKey, value ?? '');
            setState(() {
              stateValue = value;
            });
          },
          onCityChanged: (value) async {
            await SharedPreferencesService()
                .setString(SharedPreferencesService().cityKey, value ?? '');
            setState(() {
              cityValue = value;
            });
          },
        ),
        const SizedBox(height: 50),
        if (countryValue != null && stateValue != null && cityValue != null)
          Center(
            child: InkWell(
              hoverColor: Colors.transparent,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/user_profile', (route) => true);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Continue",
                      style: AppTextStyles.mediumTextStyles(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
