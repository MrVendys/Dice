// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
class CustomDataText extends StatelessWidget {
  const CustomDataText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 315,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 3),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
