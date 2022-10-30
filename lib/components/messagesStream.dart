import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'messageBubble.dart';

class MessagesStream extends StatelessWidget {
  final CollectionReference<Map<String, dynamic>> fireStore;
  final String myUser;

  const MessagesStream(
      {Key? key, required this.fireStore, required this.myUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fireStore.snapshots(),
        builder: (context, snapshot) {
          final messages = snapshot.data!.docs;
          return FutureBuilder(
              future: Future.delayed(const Duration(seconds: 2)),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator(),);
                }
                return ListView.builder(
                    addAutomaticKeepAlives: true,
                    reverse: true,
                    itemCount: messages.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: ((context, index) {
                      return ListTile(
                          title: MessageBubble(
                            messageText: (messages[index].data() as Map<
                                String,
                                dynamic>)['text'],
                            messageSender: (messages[index].data() as Map<
                                String,
                                dynamic>)['sender'],
                            myUser: myUser,
                          ));
                    }));
              });
        });
  }
}
/*List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = (message.data() as Map<String, dynamic>)['text'];
            final messageSender = (message.data() as Map<String,dynamic>)['sender'];
            final messageBubble = MessageBubble(messageText: messageText,messageSender: messageSender,myUser: mUser,);
            messageBubbles.add(messageBubble);
          }*/
