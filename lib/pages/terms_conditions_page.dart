import 'package:healthmini/utils/general_imports.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions',
            style: AppTextStyles.mediumTextStyles(fontSize: 22)),
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
          child: _buildTermsConditionsContent(context),
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
          child: _buildTermsConditionsContent(context),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _buildTermsConditionsContent(context),
    );
  }

  Widget _buildTermsConditionsContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WarningBanner(),
          Text(
            'Terms and Conditions',
            style: AppTextStyles.boldTextStyles(fontSize: 24),
          ),
          const SizedBox(height: 20),
          Text(
            'Welcome to HealthMini!',
            style: AppTextStyles.boldTextStyles(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'These terms and conditions outline the rules and regulations for the use of HealthMini\'s application and website. By accessing this application or website we assume you accept these terms and conditions. Do not continue to use HealthMini if you do not agree to take all of the terms and conditions stated on this page.',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          const SizedBox(height: 20),
          Text(
            'License',
            style: AppTextStyles.boldTextStyles(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'Unless otherwise stated, HealthMini and/or its licensors own the intellectual property rights for all material on HealthMini. All intellectual property rights are reserved. You may access this from HealthMini for your own personal use subjected to restrictions set in these terms and conditions.',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          const SizedBox(height: 20),
          Text(
            'You must not:',
            style: AppTextStyles.boldTextStyles(fontSize: 18),
          ),
          const SizedBox(height: 5),
          Text(
            '- Republish material from HealthMini',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          Text(
            '- Sell, rent or sub-license material from HealthMini',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          Text(
            '- Reproduce, duplicate or copy material from HealthMini',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          Text(
            '- Redistribute content from HealthMini',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          const SizedBox(height: 20),
          Text(
            'User Comments',
            style: AppTextStyles.boldTextStyles(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'Parts of this application/website offer an opportunity for users to post and exchange opinions and information in certain areas of the website. HealthMini does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of HealthMini,its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, HealthMini shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website.',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          const SizedBox(height: 20),
          Text(
            'Hyperlinking to our Content',
            style: AppTextStyles.boldTextStyles(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'The following organizations may link to our Website without prior written approval:',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          const SizedBox(height: 5),
          Text(
            '- Government agencies',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          Text(
            '- Search engines',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          Text(
            '- News organizations',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          const SizedBox(height: 20),
          Text(
            'Disclaimer',
            style: AppTextStyles.boldTextStyles(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our application/website and the use of this application/website. Nothing in this disclaimer will:',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          const SizedBox(height: 5),
          Text(
            '- Limit or exclude our or your liability for death or personal injury',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          Text(
            '- Limit or exclude our or your liability for fraud or fraudulent misrepresentation',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          Text(
            '- Limit any of our or your liabilities in any way that is not permitted under applicable law',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          Text(
            '- Exclude any of our or your liabilities that may not be excluded under applicable law',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          const SizedBox(height: 20),
          Text(
            'Health Tips and AI Chat',
            style: AppTextStyles.boldTextStyles(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'HealthMini provides health tips and AI chat services to help users find potential diseases by entering and selecting symptoms. While we strive to offer accurate and helpful information, these services are not a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition.',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
