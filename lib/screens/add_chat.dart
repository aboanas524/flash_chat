import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/widgets//TextFieldInput.dart';
import 'package:flash_chat/models/chat.dart';
import 'package:flash_chat/providers/chatProvider.dart';
import 'package:flash_chat/screens/chats_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_contacts/flutter_contacts.dart';


// ignore: must_be_immutable
class AddChat extends StatefulWidget {
  AddChat({Key? key}) : super(key: key);
  static String id = 'add_chat';

  @override
  State<AddChat> createState() => _AddChatState();
}

class _AddChatState extends State<AddChat> {
  TextEditingController emailController = TextEditingController();

  late Chat chat;

  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;

  late CollectionReference<Map<String, dynamic>> firebase;

  QuerySnapshot<Map<String, dynamic>>? snapshot;

  List<Contact>? contacts;
  ChatProvider chatProvider = ChatProvider();

  @override
  void initState() {
    getNumbers();
    // TODO: implement initState
    super.initState();
  }

  Future getNumbers() async
  {
    if (await FlutterContacts.requestPermission()) {
      var ccs = await FlutterContacts.getContacts(withPhoto: true,
          withProperties: true);
      contacts = ccs.where((element) => element.emails.isNotEmpty).toList();
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    firebase = FirebaseFirestore.instance.collection('chats');
    stream = firebase.snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Chat'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh),
              onPressed: () {
                getNumbers();
              }), const SizedBox(width: 10,)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: contacts?.isEmpty != false ? const Center(
            child: CircularProgressIndicator()) : ListView.builder(
            itemCount: contacts?.length ?? 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  chatProvider.addChat(Chat(
                      personName: contacts![index].displayName,
                      firstEmail: FirebaseAuth.instance.currentUser!.email!,
                      firstPhoto: contacts![index].photo!,
                      secondEmail: contacts![index].emails.first.address,
                      secondPhoto: contacts![index].photo!,
                      lastMessageTime: Timestamp.fromDate(DateTime.now())));
                  //Navigator.pushNamed(context, ChatScreen.id);
                },
                child: ListTile(
                  title: Text(contacts![index].displayName),
                  subtitle: Text(contacts![index].emails.first.address),
                  leading: CircleAvatar(child: ClipOval(
                    child: contacts![index].photo == null ? const Icon(
                        Icons.contacts) : Image.memory(
                        contacts![index].photo!),),),
                ),
              );
            }),
      ),
    );
  }
}