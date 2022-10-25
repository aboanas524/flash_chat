import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String messageText;
  final String messageSender;
  final String myUser;
  const MessageBubble({Key? key, required this.messageText, required this.messageSender, required this.myUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: myUser==messageSender?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(12),
            color: myUser==messageSender?Colors.blue:Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text(
                messageText,style:const TextStyle(color: Colors.white,fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
