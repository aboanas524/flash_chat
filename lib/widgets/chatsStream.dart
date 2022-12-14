import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/widgets//chatsStyle.dart';
import 'package:flash_chat/providers/chatProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'messageBubble.dart';

class MessagesStream extends StatelessWidget {
  final String myUser;

  const MessagesStream({Key? key, required this.myUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chats = Provider.of<ChatProvider>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
        stream: chats.stream,
        builder: (context, snapshot) {
          chats.chats.values.toList().sort((s1, s2) =>
              ((s1.lastMessageTime).compareTo((s2.lastMessageTime))));
          return ListView.builder(
              itemCount: chats.chats.length,
              scrollDirection: Axis.vertical,
              itemBuilder: ((context, index) {
                return ChatStyle(
                  chats: chats,
                  chatId: chats.chats.keys.toList()[index],
                );
              }));
        });
  }
}
/*
*  MessageBubble(
                      messageText: (messages[index].data() as Map<
                          String,
                          dynamic>)['text'],
                      messageSender: (messages[index].data() as Map<
                          String,
                          dynamic>)['sender'],
                      myUser: myUser, timeMessage:(messages[index].data() as Map<
                        String,
                        dynamic>)['dateMessage'],
                    )*/
