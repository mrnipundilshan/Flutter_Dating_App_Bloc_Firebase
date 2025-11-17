import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:datingapp/features/chat/domain/entities/message.dart';
import 'package:datingapp/features/chat/domain/repositories/chat_repositories.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepositories chatRepository;
  Stream<List<Message>>? _messageStream;

  ChatBloc(this.chatRepository) : super(ChatInitial()) {
    on<LoadMessageEvent>(_onLoadMessages);

    on<SendMessageEvent>(_onSendMessage);

    on<MarkMessageSeenEvent>(_onMarkedMessageSeen);

    on<MarkAllMessagesAsReadEvent>(_onMarkAllMessagesAsRead);

    on<_MessagesUpdatedEvent>(_onMessageUpdateEvent);
  }

  FutureOr<void> _onLoadMessages(
    LoadMessageEvent event,
    Emitter<ChatState> emit,
  ) {
    emit(ChatLoading());

    _messageStream = chatRepository.getMessages(
      event.currentUserId,
      event.peerId,
    );

    _messageStream!.listen((messages) {
      add(_MessagesUpdatedEvent(messages));
    });
  }

  FutureOr<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await chatRepository.sendMessage(
        event.senderId,
        event.receiverId,
        event.text,
      );
    } catch (e) {
      emit(ChatError("Failed to send message."));
    }
  }

  FutureOr<void> _onMarkedMessageSeen(
    MarkMessageSeenEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await chatRepository.markMessageAsSeen(event.messageId, event.chatId);
    } catch (e) {
      emit(ChatError("Failed to mark message as seen."));
    }
  }

  FutureOr<void> _onMarkAllMessagesAsRead(
    MarkAllMessagesAsReadEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await chatRepository.markAllMessagesAsRead(event.userId, event.peerId);
    } catch (e) {
      emit(ChatError("Failed to mark messages as read."));
    }
  }

  FutureOr<void> _onMessageUpdateEvent(
    _MessagesUpdatedEvent event,
    Emitter<ChatState> emit,
  ) {
    emit(ChatLoaded(event.messages));
  }

  /// Get the last message stream for a conversation
  /// This is used in the chat list to display message previews
  Stream<Message?> getLastMessage(String userId, String peerId) {
    return chatRepository.getLastMessage(userId, peerId);
  }

  /// Get unread count stream for a conversation
  Stream<int> getUnreadCount(String userId, String peerId) {
    return chatRepository.getUnreadCount(userId, peerId);
  }
}

// private internal event
class _MessagesUpdatedEvent extends ChatEvent {
  final List<Message> messages;
  const _MessagesUpdatedEvent(this.messages);

  @override
  List<Object> get props => [messages];
}
