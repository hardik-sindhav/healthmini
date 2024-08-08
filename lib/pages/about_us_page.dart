import 'package:healthmini/utils/general_imports.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  final String introductionIcon = 'assets/svg/Introduction.svg';
  final String howItsWorkIcon = 'assets/svg/how_its_work.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us',
            style: AppTextStyles.mediumTextStyles(fontSize: 22)),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return _buildDesktopLayout(context, constraints);
          } else if (constraints.maxWidth > 600) {
            return _buildTabletLayout(context, constraints);
          } else {
            return _buildMobileLayout(context, constraints);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, BoxConstraints constraints) {
    double svgSize = constraints.maxWidth * 0.2;

    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: SvgPicture.asset(
                    introductionIcon,
                    width: svgSize,
                    height: svgSize,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: _buildIntroductionContent(),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildHowWorkContent(),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: SvgPicture.asset(
                    howItsWorkIcon,
                    width: svgSize,
                    height: svgSize,
                  ),
                ),
              ],
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: _buildFAQItems(),
            ),
            const SizedBox(height: 40),
            _buildCopyrightContent(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, BoxConstraints constraints) {
    double svgSize = constraints.maxWidth * 0.3;

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: SvgPicture.asset(
                    introductionIcon,
                    width: svgSize,
                    height: svgSize,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: _buildIntroductionContent(),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildHowWorkContent(),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: SvgPicture.asset(
                    howItsWorkIcon,
                    width: svgSize,
                    height: svgSize,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: _buildFAQItems(),
            ),
            const SizedBox(height: 40),
            _buildCopyrightContent(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, BoxConstraints constraints) {
    double svgSize = constraints.maxWidth * 0.5;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SvgPicture.asset(
            introductionIcon,
            width: svgSize,
            height: svgSize,
          ),
          const SizedBox(height: 20),
          _buildIntroductionContent(),
          const SizedBox(height: 40),
          SvgPicture.asset(
            howItsWorkIcon,
            width: svgSize,
            height: svgSize,
          ),
          const SizedBox(height: 20),
          _buildHowWorkContent(),
          const SizedBox(height: 20),
          Column(
            children: _buildFAQItems(),
          ),
          const SizedBox(height: 40),
          _buildCopyrightContent(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildIntroductionContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About HealthMini',
            style: AppTextStyles.boldTextStyles(fontSize: 22)),
        const SizedBox(height: 10),
        Text(
            'Welcome to HealthMini! Our mission is to deliver trusted health tips and help you identify potential conditions based on your symptoms. With curated, up-to-date information from our expert team, we offer the best advice to enhance your well-being. Explore healthy recipes, effective exercises, and more, all tailored to support your journey to a healthier life.',
            style: AppTextStyles.mediumTextStyles(fontSize: 16)),
      ],
    );
  }

  Widget _buildHowWorkContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('How it works ?',
            style: AppTextStyles.boldTextStyles(fontSize: 22)),
        const SizedBox(height: 10),
        Text(
            'At HealthMini, we simplify your path to better health by combining symptom analysis with expert advice. Begin by entering your symptoms into our platform, and our advanced algorithms will analyze the data to suggest potential conditions. This helps you understand what might be causing your symptoms. Complementing this, our health chat AI provides personalized recommendations and answers your questions in real-time. Additionally, our expert team curates the latest health tips, including healthy recipes and exercise suggestions, to support your overall well-being.',
            style: AppTextStyles.mediumTextStyles(fontSize: 16)),
      ],
    );
  }

  List<Widget> _buildFAQItems() {
    final faqs = [
      {
        'question': 'What is HealthMini?',
        'answer':
            'HealthMini is a comprehensive health AI platform designed to help you understand and manage your health. It offers tools for identifying potential diseases based on your symptoms, predicting health conditions, providing detailed disease information, and recommending nearby hospitals.'
      },
      {
        'question': 'How does the symptom checker work?',
        'answer':
            'To use the symptom checker, enter your symptoms into HealthMini’s tool. The system analyzes your input and provides a list of possible conditions, helping you understand what might be causing your symptoms and guiding you towards appropriate medical care.'
      },
      {
        'question': 'What types of health advice does HealthMini provide?',
        'answer':
            'HealthMini offers expert-curated health advice, including personalized recommendations for yoga exercises, healthy recipes, and general wellness tips. Our health chat AI also provides tailored advice based on your specific health queries.'
      },
      {
        'question': 'How can HealthMini suggest hospitals?',
        'answer':
            'HealthMini helps you find the best hospitals in your area by analyzing your location and health needs. It provides a list of recommended hospitals to ensure you receive high-quality care close to you.'
      },
      {
        'question': 'Is my personal information secure with HealthMini?',
        'answer':
            'Yes, HealthMini is committed to protecting your privacy. We use robust security measures to ensure that all your personal information is kept confidential and secure.'
      },
      {
        'question': 'Can HealthMini predict future health conditions?',
        'answer':
            'HealthMini uses advanced algorithms to analyze your symptoms and health history to predict potential future health conditions. This feature helps you take proactive steps towards managing your health.'
      },
      {
        'question': 'How does the health chat AI work?',
        'answer':
            'The health chat AI engages with you in real-time, answering your health-related questions and providing personalized advice based on your symptoms and concerns. It acts as an additional resource for understanding and managing your health.'
      },
      {
        'question': 'What kind of disease details can I find on HealthMini?',
        'answer':
            'HealthMini provides comprehensive details about various diseases, including symptoms, causes, treatment options, and preventive measures. This information helps you understand more about different health conditions.'
      },
      {
        'question': 'How does HealthMini keep up with health trends?',
        'answer':
            'HealthMini tracks and provides information on trending symptoms and health cases globally. This feature keeps you updated on emerging health patterns and helps you stay informed about current health trends.'
      },
      {
        'question': 'Can I access HealthMini’s features on mobile devices?',
        'answer':
            'Yes, HealthMini is accessible on both mobile devices and desktops. You can use our platform from your smartphone, tablet, or computer to manage your health wherever you are.'
      }
    ];

    return faqs.map((faq) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Card(
          elevation: 3,
          color: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ExpansionTile(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: Colors.white,
            title: Text(faq['question'] ?? '',
                style: AppTextStyles.semiBoldTextStyles(fontSize: 18)),
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(faq['answer'] ?? '',
                    style: AppTextStyles.mediumTextStyles(fontSize: 16)),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildCopyrightContent() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '© 2024 HealthMini. All rights reserved.',
            style: AppTextStyles.boldTextStyles(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'No part of this site, including the concept and content, may be reproduced, distributed, or transmitted in any form or by any means, including photocopying, recording, or other electronic or mechanical methods, without the prior written permission of HealthMini. Unauthorized use and/or duplication of this material without express and written permission from this site’s author and/or owner is strictly prohibited.',
            style: AppTextStyles.normalTextStyles(
                fontSize: 14, textColor: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'HealthMini is an AI that provides health tips and helps identify potential diseases based on user symptoms.',
            style: AppTextStyles.normalTextStyles(
                fontSize: 14, textColor: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
