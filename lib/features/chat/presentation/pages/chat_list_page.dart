import 'package:datingapp/features/auth/domain/entities/app_user.dart';
import 'package:datingapp/features/chat/presentation/pages/chat_room_page.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  final List<AppUser> users;
  final String currentUserId;

  const ChatListPage({
    super.key,
    required this.users,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages")),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          if (user.uid == currentUserId) return const SizedBox();

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: const AssetImage("assets/profile.png"),
            ),
            title: Text(user.name),
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
      ),
    );
  }
}
