import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/models/message.dart';
import 'package:flutter/material.dart';

import 'package:flash_chat/models/chat.dart';

class ChatProvider extends ChangeNotifier {
  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;

  CollectionReference<Map<String, dynamic>>? firebase;
  QuerySnapshot<Map<String, dynamic>>? snapshot;
  Map<String, Chat> chats = {};
  List<Message> messages = [];
  void init(String email) async {
    firebase = FirebaseFirestore.instance.collection('chats');
    stream = firebase!.snapshots();
    stream.listen((event) {
      snapshot = event;
      chats = {};
      for (var m in event.docs) {
        if (m.data()['first_email'] == email ||
            m.data()['second_email'] == email) {
          chats[m.id] = Chat(
              personName: m.data()['person_name'],
              firstEmail: m.data()['first_email'],
              firstPhoto: base64.decode(m.data()['first_photo']),
              secondEmail: m.data()['second_email'],
              secondPhoto: base64.decode(m.data()['second_photo']),
              lastMessageTime: m.data()['last_message_time']);
        }
      }
      notifyListeners();
    });
  }

  void getChatMessages(String id) {
    firebase = FirebaseFirestore.instance.collection('chats/$id/messages');
    stream = firebase!.snapshots();
    stream.listen((event) {
      snapshot = event;
      messages = [];
      for (var m in event.docs) {
        /* 
        messages.add(Message(
            dateMessage: dateMessage,
            isMe: isMe,
            sender: sender,
            messageText: messageText)); */
      }
      notifyListeners();
    });
  }

  void addChat(Chat chat) {
    firebase ??= FirebaseFirestore.instance.collection('chats');
    firebase!.add({
      'first_email': chat.firstEmail,
      'first_photo': base64.encode(chat.firstPhoto),
      'person_name': chat.personName,
      'second_email': chat.secondEmail,
      'second_photo': base64.encode(chat.secondPhoto),
      'last_message_time': chat.lastMessageTime
    });
    notifyListeners();
  }
}
