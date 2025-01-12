import 'package:flutter/material.dart';

class CustomTextFild extends StatelessWidget {
  final String hintText;
  CustomTextFild({super.key, required this.hintText, this.onChanged});
  void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hintText == 'Password' ? true : false,
      validator: (data) {
        if (data == null || data.isEmpty) {
          return 'Enter your $hintText';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
