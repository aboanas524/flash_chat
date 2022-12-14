import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chats_screen.dart';
import 'package:flutter/material.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:flash_chat/providers/chatProvider.dart';

import 'package:flash_chat/widgets//TextFieldInput.dart';
import 'package:flash_chat/widgets//rounded_button.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  final _auth = FirebaseAuth.instance;

  late String password;
  late bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'flash',
                  child: Container(
                    child: const Image(image: AssetImage('images/logo.png')),
                    height: 200.0,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFieldInput(
                  inputText: 'email',
                  visible: false,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextFieldInput(
                  inputText: 'password',
                  visible: true,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  text: 'Login',
                  color: Colors.blueAccent,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final loginUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (loginUser != null) {
                        Provider.of<ChatProvider>(context, listen: false)
                            .init(email);
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, ChatsScreen.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
