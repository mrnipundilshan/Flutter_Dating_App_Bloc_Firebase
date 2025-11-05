import 'package:datingapp/features/chat/domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.senderId,
    required super.receiverId,
    required super.text,
    required super.timestamp,
    required super.isSeen,
  });

  factory MessageModel.fromFireStore(Map<String, dynamic> doc, String id) {
    return MessageModel(
      id: id,
      senderId: doc['senderId'],
      receiverId: doc['receiverId'],
      text: doc['text'],
      timestamp: doc['timestamp'],
      isSeen: doc['isSeen'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timestamp': timestamp,
      'isSeen': isSeen,
    };
  }
}
