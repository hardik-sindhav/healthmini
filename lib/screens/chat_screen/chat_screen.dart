import 'package:flutter/material.dart';
import 'package:healthmini/provider/chat_provider.dart';
import 'package:healthmini/screens/chat_screen/widgets/chat_message_widget.dart';
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
        title: Text('Healthmini'),
      ),
      body: Consumer<ChatProvider>(builder: (context, chatProvider, child) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.scrollController, // Attach the ScrollController
                padding: EdgeInsets.all(8),
                itemCount: chatProvider.messages.length,
                itemBuilder: (context, index) {
                  return ChatMessageWidget(
                      message: chatProvider.messages[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: _handleSend,
                          icon: chatProvider.chatState == ChatState.loading
                              ? CircularProgressIndicator()
                              : Icon(Icons.send_rounded),
                        ),
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _handleSend(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
