import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../components/TextFieldInput.dart';
import '../components/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
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
                  Hero(
                    tag: 'flash',
                    child: Container(
                      child: const Image(
                        image: AssetImage('images/logo.png')),
                      height: 200.0,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFieldInput(inputText:'email',visible: false,keyboardType: TextInputType.emailAddress,onChanged: (value){
                    email = value;
                  }),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFieldInput(inputText:'password',visible: true,keyboardType: TextInputType.visiblePassword,onChanged: (value){
                    password = value;
                  },),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    text:'Login',
                    color:Colors.blueAccent,
                    onPressed: ()async{
                      setState(() {
                        showSpinner = true;
                      });
                      try{
                        final loginUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                        if(loginUser != null)
                          {
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                        setState(() {
                          showSpinner = false;
                        });
                      }catch(e){
                        print(e);
                      }
                    },),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
