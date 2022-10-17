import 'package:flutter/material.dart';
import '../constants.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback? onPressed;
  const RoundedButton({Key? key, required this.color, required this.text,required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color:color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          textColor: Colors.white,
          minWidth: 200.0,
          height: 50.0,
          onPressed:onPressed,
          child:Text(
            text,style: kTextStyle1,
          ),
        ),
      ),
    );
  }
}
class TextFieldInput extends StatelessWidget {
  final String inputText;
  const TextFieldInput({Key? key, required this.inputText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        //Do something with the user input.
      },
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
