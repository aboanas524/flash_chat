// ignore_for_file: non_constant_identifier_names

import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import '../components/TextFieldInput.dart';
import '../components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Hero(
                      tag: 'flash',
                      child: Image(image: AssetImage('images/logo.png'), height: 200),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                     TextFieldInput(inputText: 'email',visible: false,keyboardType: TextInputType.emailAddress,onChanged: (value){email = value;},),
                    const SizedBox(
                      height: 12.0,
                    ),
                     TextFieldInput(inputText: 'password',visible: true,keyboardType: TextInputType.visiblePassword,onChanged: (value){password=value;},),
                    const SizedBox(
                      height: 24.0,
                    ),
                    RoundedButton(
                      text: 'Register', color: Colors.blueAccent,
                      onPressed: ()async{
                        setState(() {
                          showSpinner = true;
                        });
                        try{
                          final addUser =await _auth.createUserWithEmailAndPassword(email: email, password: password);
                          if(addUser != null)
                            {
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                          setState(() {
                            showSpinner =false;
                          });
                        } catch(e){
                          print(e);
                        }
                      },),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}