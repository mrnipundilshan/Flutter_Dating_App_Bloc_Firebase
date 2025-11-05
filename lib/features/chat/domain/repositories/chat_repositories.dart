import 'package:datingapp/features/chat/domain/entities/message.dart';

abstract class ChatRepositories {
  Stream<List<Message>> getMessages(String userId, String peerId);

  Future<void> sendMessage(String senderId, String receiverId, String text);

  Future<void> markMessageAsSeen(String messageId, String chatId);
}
