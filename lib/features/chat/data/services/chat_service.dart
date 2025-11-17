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

  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessageStream(
    String chatId,
  ) {
    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
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

  /// Mark all unread messages as read for a specific user in a chat
  Future<void> markAllMessagesAsRead(String chatId, String userId) async {
    final messagesSnapshot = await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('receiverId', isEqualTo: userId)
        .where('isSeen', isEqualTo: false)
        .get();

    final batch = firestore.batch();
    for (var doc in messagesSnapshot.docs) {
      batch.update(doc.reference, {'isSeen': true});
    }
    await batch.commit();

    // Reset unread count for this user
    await firestore.collection('chats').doc(chatId).set({
      'unreadCount_$userId': 0,
    }, SetOptions(merge: true));
  }

  /// Increment unread count for a user in a chat
  Future<void> incrementUnreadCount(String chatId, String userId) async {
    final chatDoc = firestore.collection('chats').doc(chatId);
    final chatData = await chatDoc.get();
    final currentCount = chatData.data()?['unreadCount_$userId'] ?? 0;

    await chatDoc.set({
      'unreadCount_$userId': currentCount + 1,
    }, SetOptions(merge: true));
  }

  /// Get unread count stream for a user in a chat
  Stream<int> getUnreadCountStream(String chatId, String userId) {
    return firestore.collection('chats').doc(chatId).snapshots().map((
      snapshot,
    ) {
      final data = snapshot.data();
      if (data == null) return 0;
      return (data['unreadCount_$userId'] as num?)?.toInt() ?? 0;
    });
  }
}
