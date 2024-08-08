import 'package:healthmini/models/chat_message_model.dart';
import 'package:healthmini/utils/general_imports.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessageModel? message;

  const ChatMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message?.isUser ?? false;
    double size = MediaQuery.of(context).size.width;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            margin: EdgeInsets.only(
                left: isUser
                    ? size > 600
                        ? 16
                        : 8
                    : 0,
                right: isUser
                    ? 0
                    : size > 600
                        ? 16
                        : 8,
                bottom: 3),
            decoration: BoxDecoration(
              color: isUser ? AppColors.appColors : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topRight: const Radius.circular(10),
                topLeft: const Radius.circular(10),
                bottomLeft: Radius.circular(isUser ? 10 : 0),
                bottomRight: Radius.circular(isUser ? 0 : 10),
              ),
            ),
            child: SelectableText(
              message?.text ?? "",
              style: AppTextStyles.mediumTextStyles(
                textColor: isUser ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              isUser
                  ? Container()
                  : InkWell(
                      onTap: () {
                        Clipboard.setData(
                                ClipboardData(text: message?.text ?? ""))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                              'Text copied to clipboard',
                              style:
                                  AppTextStyles.mediumTextStyles(fontSize: 16),
                            )),
                          );
                        });
                      },
                      child: Icon(Icons.copy_rounded,
                          color: Colors.grey[500], size: 20)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
