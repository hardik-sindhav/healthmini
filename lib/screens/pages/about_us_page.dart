import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthmini/const/colors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  final String introductionIcon = 'assets/svg/Introduction.svg';
  final String howItsWorkIcon = 'assets/svg/how_its_work.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            // Desktop Layout
            return _buildDesktopLayout(context, constraints);
          } else if (constraints.maxWidth > 600) {
            // Tablet Layout
            return _buildTabletLayout(context, constraints);
          } else {
            // Mobile Layout
            return _buildMobileLayout(context, constraints);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, BoxConstraints constraints) {
    double svgSize = constraints.maxWidth *
        0.2; // Adjust SVG size based on constraints

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
              physics: NeverScrollableScrollPhysics(),
              children: _buildFAQItems(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, BoxConstraints constraints) {
    double svgSize = constraints.maxWidth *
        0.3; // Adjust SVG size based on constraints

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
              physics: NeverScrollableScrollPhysics(),
              children: _buildFAQItems(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, BoxConstraints constraints) {
    double svgSize = constraints.maxWidth *
        0.5; // Adjust SVG size based on constraints

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
        ],
      ),
    );
  }

  Widget _buildIntroductionContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Introduction',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Welcome to our health site! Our mission is to provide you with reliable health tips and help you find potential diseases from your symptoms. Our expert team curates the latest information to ensure you receive the best advice for maintaining your health and well-being.',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildHowWorkContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How it works ?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Welcome to our health site! Our mission is to provide you with reliable health tips and help you find potential diseases from your symptoms. Our expert team curates the latest information to ensure you receive the best advice for maintaining your health and well-being.',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFAQItems() {
    final faqs = [
      {
        'question': 'What is your health site about?',
        'answer': 'Our health site provides reliable health tips and helps you identify potential diseases from your symptoms.',
      },
      {
        'question': 'How do I use the symptom checker?',
        'answer': 'Simply enter your symptoms into the symptom checker, and it will provide you with a list of possible conditions.',
      },
      {
        'question': 'Are the health tips provided by experts?',
        'answer': 'Yes, all our health tips are curated by experts to ensure you receive the best advice for maintaining your health.',
      },
      {
        'question': 'Is my personal information safe?',
        'answer': 'Yes, we prioritize your privacy and ensure that all your personal information is kept secure.',
      },
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
            title: Text(
              faq['question']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  faq['answer']!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

}

