class ChatMessage {
  final String id;
  final String text;
  final DateTime time;
  final bool isMe;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
  });

  String get timeLabel {
    final hour24 = time.hour;
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = hour24 >= 12 ? 'PM' : 'AM';
    return '$hour12:$minute $period';
  }
}
