import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'messageBubble.dart';

class MessagesStream extends StatelessWidget {
  final FirebaseFirestore fireStore;
  final String mUser;
  const MessagesStream({Key? key, required this.fireStore, required this.mUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('messages').snapshots(),
        builder: (context, snapshot) {

          final messages = snapshot.data?.docs;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages!) {
            final messageText = (message.data() as Map<String,
                dynamic>)['text'];
            final messageSender = (message.data() as Map<
                String,
                dynamic>)['sender'];
            final messageBubble = MessageBubble(messageText: messageText,messageSender: messageSender,myUser: mUser,);
            messageBubbles.add(messageBubble);
          }
            return Expanded(
              child: ListView(
                children: messageBubbles,
              ),
            );
        }
    );
  }
}
