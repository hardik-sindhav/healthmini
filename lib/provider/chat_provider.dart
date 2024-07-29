import 'package:flutter/material.dart';
import 'package:healthmini/api/gemini_api.dart';
import 'package:healthmini/helper/prompt_helper.dart';
import 'package:healthmini/models/chat_message_model.dart';

enum ChatState {
  initial,
  loaded,
  loading,
  error,
}

class ChatProvider extends ChangeNotifier {
  ChatState chatState = ChatState.initial;
  final ScrollController scrollController = ScrollController();

  final List<ChatMessageModel> messages = [
    ChatMessageModel(
      id: '1',
      text: 'Hi, I’m HealthMini! Ready to help you with tips and advice for a healthier lifestyle. How can I assist you today ?',
      isUser: false,
    ),
  ];

  Future<void> sendMessage(String question) async {
    final newMessageId = DateTime.now().toString();
    messages
        .add(ChatMessageModel(id: newMessageId, isUser: true, text: question));
    scrollToBottom();
    notifyListeners();

    chatState = ChatState.loading;
    notifyListeners();

    var res = await GeminiApi()
        .callGemini(PromptHelper().generateUserQuestionPrompt(question));
    if (res != null) {
      messages.add(ChatMessageModel(
          id: DateTime.now().toString(), isUser: false, text: res["message"]));
      scrollToBottom();
      chatState = ChatState.loaded;
      notifyListeners();
    } else {
      chatState = ChatState.error;
      notifyListeners();
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
