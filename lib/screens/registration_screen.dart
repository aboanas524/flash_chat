// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../components/rounded_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

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
            const Hero(
              tag: 'flash',
              child: Image(image: AssetImage('images/logo.png'), height: 200),
            ),
            const SizedBox(
              height: 50.0,
            ),
            const TextFieldInput(inputText: 'email',),
            const SizedBox(
              height: 12.0,
            ),
            const TextFieldInput(inputText: 'password',),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              text: 'Register', color: Colors.blueAccent,
              onPressed: () {},),
          ],
        ),
      ),
    );
  }
}