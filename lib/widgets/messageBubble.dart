import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final String messageText;
  final String messageSender;
  final String myUser;
  final Timestamp timeMessage;

  const MessageBubble(
      {Key? key, required this.messageText, required this.messageSender, required this.myUser, required this.timeMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: myUser == messageSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 5,
            borderRadius: myUser == messageSender ? const BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(25)) : const BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(30)),
            color: myUser == messageSender ? Colors.blue : Colors.grey,
            child: Padding(
              padding: myUser == messageSender? const EdgeInsets.only(left: 20,top: 5,bottom: 5,right: 20):const EdgeInsets.only(left: 14,bottom: 5,top: 5,right: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myUser==messageSender?const SizedBox():Text(messageSender,style:const TextStyle(color: Colors.amberAccent),),
                  Text(
                    messageText,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(DateFormat('h:mm a').format( timeMessage.toDate()),style:const TextStyle(fontSize: 10,color: Colors.white70),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
