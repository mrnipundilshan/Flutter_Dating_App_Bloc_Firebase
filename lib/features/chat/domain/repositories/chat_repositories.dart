import 'package:datingapp/features/chat/domain/entities/message.dart';

abstract class ChatRepositories {
  Stream<List<Message>> getMessages(String userId, String peerId);

  Stream<Message?> getLastMessage(String userId, String peerId);

  Future<void> sendMessage(String senderId, String receiverId, String text);

  Future<void> markMessageAsSeen(String messageId, String chatId);

  Future<void> markAllMessagesAsRead(String userId, String peerId);

  Future<void> incrementUnreadCount(String senderId, String receiverId);

  Stream<int> getUnreadCount(String userId, String peerId);
}
