import 'package:healthmini/utils/general_imports.dart';

class RefundPolicyPage extends StatelessWidget {
  const RefundPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Refund Policy',
          style: AppTextStyles.mediumTextStyles(fontSize: 22),
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
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: _buildRefundPolicyContent(context),
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
          child: _buildRefundPolicyContent(context),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _buildRefundPolicyContent(context),
    );
  }

  Widget _buildRefundPolicyContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WarningBanner(),
          Text(
            'Refund Policy',
            style: AppTextStyles.boldTextStyles(fontSize: 24),
          ),
          const SizedBox(height: 20),
          Text(
            'Overview',
            style: AppTextStyles.boldTextStyles(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'Thank you for purchasing our digital products. We ensure that our users have a smooth experience when acquiring our source code. As our product is digital in nature and is delivered immediately after payment, we maintain a strict no-refund policy.',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          const SizedBox(height: 20),
          Text(
            'No Refunds Policy',
            style: AppTextStyles.boldTextStyles(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            '- All sales are final. Due to the nature of digital products, we do not offer refunds or exchanges after purchase.',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          Text(
            '- Once the payment is processed, the source code is immediately delivered to your provided email or download link.',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          const SizedBox(height: 20),
          Text(
            'Exceptions',
            style: AppTextStyles.boldTextStyles(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'We do offer refunds in the following limited cases:',
            style: AppTextStyles.semiBoldTextStyles(fontSize: 16),
          ),
          Text(
            '- You were charged multiple times for the same product due to a technical error.',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          Text(
            '- You did not receive the source code after payment due to system malfunction. In this case, we will attempt to resolve the issue before issuing a refund.',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          const SizedBox(height: 20),
          Text(
            'Refund Request Process',
            style: AppTextStyles.boldTextStyles(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'To request a refund in the above exceptional cases, please follow these steps:',
            style: AppTextStyles.semiBoldTextStyles(fontSize: 16),
          ),
          Text(
            '- Contact our support team at viragvadhel7@gmail.com within 7 days of purchase.',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          Text(
            '- Provide your order ID and a detailed description of the issue.',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          const SizedBox(height: 20),
          Text(
            'Chargebacks & Disputes',
            style: AppTextStyles.boldTextStyles(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'If you initiate a chargeback or dispute without following our refund process, your access to future purchases may be restricted, and your account may be flagged.',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          const SizedBox(height: 20),
          Text(
            'Contact Us',
            style: AppTextStyles.boldTextStyles(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'If you have any questions or concerns regarding this refund policy, please contact us at:',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          Text(
            'Email: viragvadhel7@gmail.com',
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
