import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/widgets//chatsStream.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatsScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatsScreen({Key? key}) : super(key: key);
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  final _auth = FirebaseAuth.instance;
   User? loggedInUser;

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
      child:Scaffold(
        floatingActionButton:FloatingActionButton(
          child:const Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, 'add_chat');
          },) ,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushNamed(context, LoginScreen.id);
                  }),
            ],
            title: const Text('  ⚡️Chats'),
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
                Expanded(child: MessagesStream(
                    myUser: loggedInUser?.email.toString()??'')),
              ],
            ),
          )
      ),
    );
  }
}