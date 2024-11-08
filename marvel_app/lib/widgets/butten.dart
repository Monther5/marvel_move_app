import 'package:flutter/material.dart';
import 'package:marvel_app/helper/colors.dart';


class Mainbutton extends StatelessWidget {
  const Mainbutton({
    super.key,
    required this.text,
    required this.onPressed,
    this.btncolor,
    this.txtcolor,
  });
  final String text;
  final Function onPressed;
  final Color? btncolor;
  final Color? txtcolor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        backgroundColor: btncolor ?? redColor, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18,
            color: txtcolor ?? Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}