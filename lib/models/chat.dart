

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String firstEmail;
  final String personName;
  final Uint8List firstPhoto;
  final String secondEmail;
  final Uint8List secondPhoto;
  final Timestamp lastMessageTime;

  Chat({
    required this.personName,
    required this.firstEmail,
    required this.firstPhoto,
    required this.secondEmail,
    required this.secondPhoto,
    required this.lastMessageTime
  });
}
