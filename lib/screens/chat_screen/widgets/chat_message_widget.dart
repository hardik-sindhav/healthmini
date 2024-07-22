import 'package:flutter/material.dart';
import 'package:healthmini/const/colors.dart';
import 'package:healthmini/models/chat_message_model.dart';
import 'package:healthmini/utils/textstyles.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessageModel? message;

  const ChatMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message?.isUser ?? false;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: EdgeInsets.only(left: isUser ? 40 : 0,right: isUser ? 0 : 40,bottom: 10),
        decoration: BoxDecoration(
          color: isUser ? AppColors.appColors : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(10),
            topLeft: const Radius.circular(10),
            bottomLeft: Radius.circular(isUser ? 10 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 10),
          ),
        ),
        child: Text(
          message?.text ?? "",
          style: AppTextStyles.mediumTextStyles(
            textColor: isUser ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
