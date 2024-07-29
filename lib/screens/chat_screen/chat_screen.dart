import 'package:flutter/material.dart';
import 'package:healthmini/const/colors.dart';
import 'package:healthmini/provider/chat_provider.dart';
import 'package:healthmini/screens/chat_screen/widgets/chat_message_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _handleSend() async {
    final text = _controller.text;
    if (text.isNotEmpty) {
      Provider.of<ChatProvider>(context, listen: false).sendMessage(text);
      _controller.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthmini'),
      ),
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              double size = constraints.maxWidth;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: chatProvider.scrollController,
                      padding: EdgeInsets.all(size > 600 ? 16 : 8),
                      itemCount: chatProvider.messages.length,
                      itemBuilder: (context, index) {
                        return ChatMessageWidget(
                          message: chatProvider.messages[index],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size > 600 ? 24 : 15,
                      vertical: size > 600 ? 16 : 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: _handleSend,
                                icon: chatProvider.chatState == ChatState.loading
                                    ? LoadingAnimationWidget.horizontalRotatingDots(
                                  color: AppColors.appColors,
                                  size: 35,
                                )
                                    : const Icon(Icons.send_rounded),
                              ),
                              hintText: 'Type a message...',
                              border: const OutlineInputBorder(),
                            ),
                            onSubmitted: (_) => _handleSend(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
