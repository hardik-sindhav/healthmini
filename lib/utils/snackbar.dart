import 'package:flutter/material.dart';
import 'package:healthmini/utils/textstyles.dart';

enum MessageType {
  success,
  warning,
  error,
}

void showCustomSnackbar(BuildContext context, String message, MessageType type) {
  Color backgroundColor;
  IconData iconData;

  switch (type) {
    case MessageType.success:
      backgroundColor = Colors.green.shade400;
      iconData = Icons.check_circle_outline_rounded;
      break;
    case MessageType.warning:
      backgroundColor = Colors.orange.shade400;
      iconData = Icons.warning_amber_rounded;
      break;
    case MessageType.error:
      backgroundColor = Colors.red.shade400;
      iconData = Icons.error_outline_rounded;
      break;
  }

  final snackbar = SnackBar(
    padding: EdgeInsets.all(8),
    content: Row(
      children: [
        Icon(iconData, color: Colors.white),
        const SizedBox(width: 10),
        Expanded(child: Text(message, style: AppTextStyles.mediumTextStyles(textColor: Colors.white,fontSize: 14))),
      ],
    ),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    margin: const EdgeInsets.all(10),
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
