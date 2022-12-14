import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flash_chat/providers/chatProvider.dart';

class ChatStyle extends StatelessWidget {
  const ChatStyle({Key? key, required this.chats, required this.chatId})
      : super(key: key);
  final ChatProvider chats;
  final String chatId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => ChatScreen(chatId: chatId)));
        },
        title: Text(chats.chats[chatId]!.personName),
        leading: SizedBox(
            height: 80,
            width: 65,
            child: ClipOval(
              child: chats.chats[chatId]!.secondPhoto.isEmpty
                  ? const Icon(Icons.person, size: 35, color: Colors.grey)
                  : Image.memory(
                      chats.chats[chatId]!.secondPhoto,
                      fit: BoxFit.cover,
                    ),
            )),
        subtitle: Text(DateFormat.yMd()
            .add_jm()
            .format(chats.chats[chatId]!.lastMessageTime.toDate())),
      ),
    );
  }
}
