import 'package:flash_chat/components/messagesStream.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  final _fireStore = FirebaseFirestore.instance.collection('messages');
  final messageTextController = TextEditingController();
  late String messageText;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  void getCurrentUser() async
  {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print('Error in auth = $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: null,
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushNamed(context, WelcomeScreen.id);
                  }),
            ],
            title: const Text('⚡️Chat'),
            backgroundColor: Colors.lightBlueAccent,
          ),
          body: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(child: MessagesStream(fireStore: _fireStore,
                    myUser: loggedInUser.email.toString())),
                Container(
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
                            _fireStore.add({
                              'text': messageTextController.text,
                              'sender': loggedInUser.email
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
              ],
            ),
          )
      ),
    );
  }
}
