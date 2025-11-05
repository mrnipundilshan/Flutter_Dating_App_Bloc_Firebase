import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/features/chat/data/models/message_model.dart';
import 'package:datingapp/features/chat/domain/entities/message.dart';
import 'package:datingapp/features/chat/domain/repositories/chat_repositories.dart';

class ChatRepositoryImpl implements ChatRepositories {
  final FirebaseFirestore firestore;

  ChatRepositoryImpl(this.firestore);

  String _chatId(String uid1, String uid2) {
    return uid1.hashCode <= uid2.hashCode ? '$uid1-$uid2' : '$uid2-$uid1';
  }

  @override
  Stream<List<Message>> getMessages(String userId, String peerId) {
    final chatId = _chatId(userId, peerId);

    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => MessageModel.fromFireStore(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Future<void> markMessageAsSeen(String messageId, String chatId) async {
    await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({'isSeen': true});
  }

  @override
  Future<void> sendMessage(
    String senderId,
    String receiverId,
    String text,
  ) async {
    final chatId = _chatId(senderId, receiverId);

    final message = MessageModel(
      id: '',
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      timestamp: DateTime.now(),
      isSeen: false,
    );

    await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toMap());
  }
}
