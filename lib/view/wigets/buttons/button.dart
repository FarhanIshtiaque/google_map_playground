import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({

    Key? key, required this.onPressed, required this.buttonNameWidget,
  }) : super(key: key);
  final VoidCallback onPressed;

  final Widget buttonNameWidget;


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.deepPurple,
      elevation: 0,
      height: 50,
      minWidth: double.infinity,
      onPressed: onPressed,

      child: buttonNameWidget,

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)),
    );
  }
}