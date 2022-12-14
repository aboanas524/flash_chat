import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/chatProvider.dart';

class ChatStyle extends StatelessWidget {
  const ChatStyle({Key? key, required this.chats, required this.index})
      : super(key: key);
  final ChatProvider chats;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(chats.chats[index].personName),
          leading: SizedBox(height: 80,
              width: 65,
              child: ClipOval(
                child: chats.chats[index].secondPhoto.isEmpty ? const Icon(
                    Icons.person, size: 35, color: Colors.grey) : Image.memory(
                  chats.chats[index].secondPhoto, fit: BoxFit.cover,),)),
          subtitle: Text(DateFormat.yMd().add_jm().format(
              chats.chats[index].lastMessageTime.toDate())),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
