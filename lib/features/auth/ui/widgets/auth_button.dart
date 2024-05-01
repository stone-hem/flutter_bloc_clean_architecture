import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthButton({super.key,required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, style: ElevatedButton.styleFrom(
      fixedSize: Size(MediaQuery.of(context).size.width*0.9, 55)
    ), child: Text(buttonText));
  }
}
