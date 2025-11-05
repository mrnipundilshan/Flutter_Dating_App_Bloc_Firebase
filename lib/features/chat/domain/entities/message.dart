import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime timestamp;
  final bool isSeen;

  const Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
    required this.isSeen,
  });

  @override
  List<Object?> get props => [
    id,
    senderId,
    receiverId,
    text,
    timestamp,
    isSeen,
  ];
}
