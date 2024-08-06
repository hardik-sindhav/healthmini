import 'package:flutter/material.dart';
import 'package:healthmini/utils/textstyles.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: MediaQuery.of(context).size.width * 0.2,
          ),
          const SizedBox(height: 20),
           Text(
            'Thank you!',
            style: AppTextStyles.boldTextStyles(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
           Text(
            'We have received your message and will get back to you soon.',
            textAlign: TextAlign.center,
            style: AppTextStyles.normalTextStyles(
              fontSize: 16,
            ),
          ),
        ],
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ),
      ],
    );
  }
}
