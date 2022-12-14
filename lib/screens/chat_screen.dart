import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
   final  _firestore = FirebaseFirestore.instance.collection('chats');
  final messageTextController = TextEditingController();
  late String messageText;
  @override
  Widget build(BuildContext context) {
    print(_firestore);
    return Scaffold(
      appBar: AppBar(
        title:const Text(''),
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
                  _firestore.add({
                    'text': messageTextController.text,
                    'sender': FirebaseAuth.instance.currentUser?.email,
                    'dateMessage':DateTime.now()
                  });
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
