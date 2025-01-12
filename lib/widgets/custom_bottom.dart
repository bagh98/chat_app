import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
  final String text;

  final VoidCallback? onTap;
  const CustomBottom({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff2B476E),
              ),
            ),
          )),
    );
  }
}
