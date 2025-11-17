import 'package:datingapp/features/chat/data/models/message_model.dart';
import 'package:datingapp/features/chat/data/services/chat_service.dart';
import 'package:datingapp/features/chat/domain/entities/message.dart';
import 'package:datingapp/features/chat/domain/repositories/chat_repositories.dart';

class ChatRepositoryImpl implements ChatRepositories {
  final ChatService chatService;

  ChatRepositoryImpl(this.chatService);

  @override
  Stream<List<Message>> getMessages(String userId, String peerId) {
    final chatId = chatService.getChatId(userId, peerId);

    return chatService
        .getMessageStream(chatId)
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => MessageModel.fromFireStore(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Stream<Message?> getLastMessage(String userId, String peerId) {
    final chatId = chatService.getChatId(userId, peerId);

    return chatService.getLastMessageStream(chatId).map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return null;
      }
      final doc = snapshot.docs.first;
      return MessageModel.fromFireStore(doc.data(), doc.id);
    });
  }

  @override
  Future<void> sendMessage(
    String senderId,
    String receiverId,
    String text,
  ) async {
    final chatId = chatService.getChatId(senderId, receiverId);

    final message = MessageModel(
      id: '',
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      timestamp: DateTime.now(),
      isSeen: false,
    );

    await chatService.sendMessage(chatId, message.toMap());

    // Increment unread count for the receiver
    await chatService.incrementUnreadCount(chatId, receiverId);
  }

  @override
  Future<void> markMessageAsSeen(String messageId, String chatId) async {
    await chatService.markMessageAsSeen(chatId, messageId);
  }

  @override
  Future<void> markAllMessagesAsRead(String userId, String peerId) async {
    final chatId = chatService.getChatId(userId, peerId);
    await chatService.markAllMessagesAsRead(chatId, userId);
  }

  @override
  Future<void> incrementUnreadCount(String senderId, String receiverId) async {
    final chatId = chatService.getChatId(senderId, receiverId);
    await chatService.incrementUnreadCount(chatId, receiverId);
  }

  @override
  Stream<int> getUnreadCount(String userId, String peerId) {
    final chatId = chatService.getChatId(userId, peerId);
    return chatService.getUnreadCountStream(chatId, userId);
  }
}
