import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: _buildPrivacyPolicyContent(context),
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: _buildPrivacyPolicyContent(context),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _buildPrivacyPolicyContent(context),
    );
  }

  Widget _buildPrivacyPolicyContent(BuildContext context) {
    return SingleChildScrollView(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Privacy Policy',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Introduction',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Welcome to HealthMini ! Your privacy is critically important to us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our application or website. Please read this privacy policy carefully. If you do not agree with the terms of this privacy policy, please do not access the application or website.',
          ),
          SizedBox(height: 20),
          Text(
            'Information We Collect',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Personal Data',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            '- Contact Information: We may collect your address, and other contact details when you register or contact us.',
          ),
          Text(
            '- Health Information: We may collect data related to your health, symptoms, and medical history when you use our services to find potential diseases.',
          ),
          SizedBox(height: 10),
          Text(
            'Usage Data',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'We collect information about your usage of our app/site, such as the features you use, the pages you visit, and the actions you take.',
          ),
          SizedBox(height: 10),
          Text(
            'Device Data',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'We may collect information about your device, including its IP address, operating system, browser type, and device identifiers.',
          ),
          SizedBox(height: 20),
          Text(
            'How We Use Your Information',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'We use the collected information to:',
          ),
          Text(
            '- Provide, operate, and maintain our services.',
          ),
          Text(
            '- Improve, personalize, and expand our services.',
          ),
          Text(
            '- Understand and analyze how you use our services.',
          ),
          Text(
            '- Develop new products, services, features, and functionality.',
          ),
        ],
      ),
    );
  }
}

