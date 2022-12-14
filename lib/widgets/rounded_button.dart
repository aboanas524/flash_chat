import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback? onPressed;
  const RoundedButton(
      {Key? key,
      required this.color,
      required this.text,
      required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          textColor: Colors.white,
          minWidth: 200.0,
          height: 50.0,
          onPressed: onPressed,
          child: Text(
            text,
            style: kTextStyle1,
          ),
        ),
      ),
    );
  }
}
