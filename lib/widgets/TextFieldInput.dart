import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String inputText;
  final bool visible;
  final TextInputType keyboardType;
  ValueChanged<String>? onChanged;
  TextFieldInput({super.key, required this.onChanged, required this.inputText, required this.visible, required this.keyboardType});
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      obscureText: visible,
      textAlign: TextAlign.center,
      onChanged: onChanged,
      decoration:InputDecoration(
        hoverColor: Colors.black,
        focusColor: Colors.black,
        hintText:'Enter your $inputText',
        contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border:const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder:const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder:const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
