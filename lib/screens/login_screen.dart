import 'package:flutter/material.dart';

import '../components/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
            const TextFieldInput(inputText:'email',),
            const SizedBox(
              height: 12.0,
            ),
            const TextFieldInput(inputText:'password',),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              text:'Login',
              color:Colors.blueAccent,
              onPressed: (){},),
          ],
        ),
      ),
    );
  }
}
