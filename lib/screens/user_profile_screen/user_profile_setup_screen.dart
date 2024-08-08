import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthmini/service/shared_preferences_service.dart';
import 'package:healthmini/utils/textstyles.dart';
import 'package:intl/intl.dart'; // For formatting date

class UserProfileSetupScreen extends StatefulWidget {
  const UserProfileSetupScreen({super.key});

  @override
  _UserProfileSetupScreenState createState() => _UserProfileSetupScreenState();
}

class _UserProfileSetupScreenState extends State<UserProfileSetupScreen> {
  int? age;
  DateTime? selectedDate;
  String? gender;
  final _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Set Up Your Profile",
          style: AppTextStyles.mediumTextStyles(fontSize: 20),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return _buildDesktopLayout(context);
          } else if (constraints.maxWidth > 600) {
            return _buildTabletLayout(context);
          } else {
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
              "assets/svg/profile_setup.svg",
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
              "assets/svg/profile_setup.svg",
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
            "assets/svg/profile_setup.svg",
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
          "Please complete your profile by selecting your date of birth and gender. This information helps us provide more accurate health insights.",
          style: AppTextStyles.normalTextStyles(fontSize: 14),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 20),
        Text(
          "Date of Birth",
          style: AppTextStyles.boldTextStyles(fontSize: 16),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Text(
                  selectedDate != null
                      ? _dateFormat.format(selectedDate!)
                      : "Select your date of birth",
                  style: AppTextStyles.mediumTextStyles(fontSize: 16),
                ),
                const Spacer(),
                const Icon(Icons.calendar_today, color: Colors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          "Gender",
          style: AppTextStyles.boldTextStyles(fontSize: 16),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Male",
                  style: AppTextStyles.mediumTextStyles(fontSize: 16),
                ),
                value: "Male",
                groupValue: gender,
                onChanged: (value) async {
                  setState(() {
                    gender = value;
                  });
                  await SharedPreferencesService().setString(
                      SharedPreferencesService().genderKey,
                      value??'');
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Female",
                  style: AppTextStyles.mediumTextStyles(fontSize: 16),
                ),
                value: "Female",
                groupValue: gender,
                onChanged: (value) async {
                  setState(() {
                    gender = value;
                  });
                  await SharedPreferencesService().setString(
                      SharedPreferencesService().genderKey,
                      value??'');
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Other",
                  style: AppTextStyles.mediumTextStyles(fontSize: 16),
                ),
                value: "Other",
                groupValue: gender,
                onChanged: (value) async {
                  setState(() {
                    gender = value;
                  });
                  await SharedPreferencesService().setString(
                      SharedPreferencesService().genderKey,
                      value??'');
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        if (selectedDate != null && gender != null)
          Center(
            child: InkWell(
              hoverColor: Colors.transparent,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        age = _calculateAge(pickedDate);
      });

      await SharedPreferencesService().setString(
        SharedPreferencesService().ageKey,
        age.toString(),
      );
    }
  }

  int _calculateAge(DateTime birthDate) {
    final DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
