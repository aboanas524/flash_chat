import 'package:flash_chat/constants.dart';
import 'package:flash_chat/providers/chatProvider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  const ChatScreen({Key? key, required this.chatId}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  late String messageText;
  @override
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false)
        .getChatMessages(widget.chatId);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ChatProvider>(context).messages;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(
        decoration: kMessageContainerDecoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: messageTextController,
                onChanged: (value) {
                  messageTextController.text = value;
                },
                decoration: kMessageTextFieldDecoration,
              ),
            ),
            MaterialButton(
              onPressed: () {
                try {
                  /* 
                  _firestore.add({
                    'text': messageTextController.text,
                    'sender': FirebaseAuth.instance.currentUser?.email,
                    'dateMessage': DateTime.now()
                  }); */
                } catch (e) {
                  print('Error in Adding = $e');
                }
                messageTextController.clear();
              },
              child: const Text(
                'Send',
                style: kSendButtonTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
