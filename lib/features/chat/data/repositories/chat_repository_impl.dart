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
  }

  @override
  Future<void> markMessageAsSeen(String messageId, String chatId) async {
    await chatService.markMessageAsSeen(chatId, messageId);
  }
}
