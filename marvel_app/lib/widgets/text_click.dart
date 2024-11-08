import 'package:flutter/material.dart';

class TextClickable extends StatelessWidget {
  const TextClickable(
      {super.key, required this.text, required this.function, this.color});
  final String text;
  final Function function;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text,
        style: TextStyle(
            fontSize: 14,
            color: color ?? Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}