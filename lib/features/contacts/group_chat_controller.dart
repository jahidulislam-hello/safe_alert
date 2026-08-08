import 'package:safe_alert/features/contacts/chat_message.dart';
import 'package:flutter/material.dart';


/// Drives the Group Chat screen: message history and sending new messages.
class GroupChatController extends ChangeNotifier {
  GroupChatController() {
    _seed();
  }

  final TextEditingController textController = TextEditingController();

  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => List.unmodifiable(_messages);

  bool get canSend => textController.text.trim().isNotEmpty;

  void _seed() {
    final base = DateTime(2026, 8, 7, 12, 37);
    _messages.addAll([
      ChatMessage(id: 'm1', text: 'How can I help you today?', time: base, isMe: false),
      ChatMessage(id: 'm2', text: 'ok', time: base, isMe: true),
      ChatMessage(
        id: 'm3',
        text: 'I understand your concern. Let me help you with that. Would you like to schedule a video consultation?',
        time: base,
        isMe: false,
      ),
      ChatMessage(id: 'm4', text: 'consultation fee ?', time: base.add(const Duration(minutes: 1)), isMe: true),
      ChatMessage(
        id: 'm5',
        text: 'I understand your concern. Let me help you with that. Would you like to schedule a video consultation?',
        time: base.add(const Duration(minutes: 1)),
        isMe: false,
      ),
      ChatMessage(
        id: 'm6',
        text: "I've set the consultation fee at 12 XAF for a 30-minute video consultation. This includes follow-up messages for 24 hours.",
        time: base.add(const Duration(minutes: 1)),
        isMe: false,
      ),
    ]);
  }

  void onTextChanged(String _) => notifyListeners();

  void send() {
    final text = textController.text.trim();
    if (text.isEmpty) return;
    _messages.add(
      ChatMessage(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        text: text,
        time: DateTime.now(),
        isMe: true,
      ),
    );
    textController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
