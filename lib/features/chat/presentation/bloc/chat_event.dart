part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadMessageEvent extends ChatEvent {
  final String currentUserId;
  final String peerId;

  const LoadMessageEvent({required this.currentUserId, required this.peerId});

  @override
  List<Object> get props => [currentUserId, peerId];
}

class SendMessageEvent extends ChatEvent {
  final String senderId;
  final String receiverId;
  final String text;

  const SendMessageEvent({
    required this.senderId,
    required this.receiverId,
    required this.text,
  });

  @override
  List<Object> get props => [senderId, receiverId, text];
}

class MarkMessageSeenEvent extends ChatEvent {
  final String chatId;
  final String messageId;

  const MarkMessageSeenEvent({required this.chatId, required this.messageId});

  @override
  List<Object> get props => [chatId, messageId];
}
