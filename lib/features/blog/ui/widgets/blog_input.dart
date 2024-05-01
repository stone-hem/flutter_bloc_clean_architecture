import 'package:flutter/material.dart';

class BlogInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isTextObscure;
  final int maxLines;
  const BlogInput({super.key,required this.hintText,required this.controller,this.isTextObscure=false, required this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isTextObscure,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value){
        if(value!.isEmpty){
          return '$hintText is missing';
        }
        return null;
      },
    );
  }
}
