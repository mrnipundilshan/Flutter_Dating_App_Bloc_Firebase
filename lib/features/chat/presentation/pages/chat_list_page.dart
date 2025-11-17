import 'package:datingapp/features/auth/domain/entities/app_user.dart';
import 'package:datingapp/features/chat/domain/entities/message.dart';
import 'package:datingapp/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:datingapp/features/chat/presentation/pages/chat_room_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListPage extends StatelessWidget {
  final List<AppUser> users;
  final String currentUserId;

  const ChatListPage({
    super.key,
    required this.users,
    required this.currentUserId,
  });

  String _getPreviewText(Message? message, String currentUserId) {
    if (message == null) {
      return "No messages yet";
    }
    final isSentByMe = message.senderId == currentUserId;
    return isSentByMe ? "You: ${message.text}" : message.text;
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return "Just now";
        }
        return "${difference.inMinutes}m ago";
      }
      return "${difference.inHours}h ago";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    } else {
      // Format as date: "MMM dd" or "MMM dd, yyyy" if different year
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      if (timestamp.year == now.year) {
        return "${months[timestamp.month - 1]} ${timestamp.day}";
      } else {
        return "${months[timestamp.month - 1]} ${timestamp.day}, ${timestamp.year}";
      }
    }
  }

  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return "${text.substring(0, maxLength)}...";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Messages",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          if (user.uid == currentUserId) return const SizedBox();

          final chatBloc = context.read<ChatBloc>();
          final lastMessageStream = chatBloc.getLastMessage(
            currentUserId,
            user.uid,
          );
          final unreadCountStream = chatBloc.getUnreadCount(
            currentUserId,
            user.uid,
          );

          return StreamBuilder(
            stream: lastMessageStream,
            builder: (context, messageSnapshot) {
              final message = messageSnapshot.data;
              final previewText = _getPreviewText(message, currentUserId);
              final displayText = _truncateText(previewText, 40);
              final timestampText = message != null
                  ? _formatTimestamp(message.timestamp)
                  : "";

              return StreamBuilder<int>(
                stream: unreadCountStream,
                builder: (context, unreadSnapshot) {
                  final unreadCount = unreadSnapshot.data ?? 0;

                  return ListTile(
                    contentPadding: const EdgeInsets.only(
                      bottom: 10,
                      left: 20,
                      right: 20,
                    ),
                    leading: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("assets/profile.png"),
                    ),
                    title: Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: unreadCount > 0
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: Text(
                            displayText,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: unreadCount > 0
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (timestampText.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Text(
                            timestampText,
                            style: TextStyle(
                              fontSize: 12,
                              color: unreadCount > 0
                                  ? Colors.pink
                                  : Colors.grey[500],
                              fontWeight: unreadCount > 0
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ],
                    ),
                    trailing: unreadCount > 0
                        ? Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              unreadCount > 99 ? '99+' : unreadCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : null,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatRoomPage(
                            currentUserId: currentUserId,
                            peerUser: user,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
