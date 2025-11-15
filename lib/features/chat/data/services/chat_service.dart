import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore firestore;
  ChatService(this.firestore);

  String getChatId(String uid1, String uid2) {
    return uid1.hashCode <= uid2.hashCode ? "$uid1 - $uid2" : "$uid2 - $uid1";
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessageStream(String chatId) {
    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> sendMessage(String chatId, Map<String, dynamic> message) async {
    await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message);
  }

  Future<void> markMessageAsSeen(String chatId, String messageId) async {
    await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({'isSeen': true});
  }
}
