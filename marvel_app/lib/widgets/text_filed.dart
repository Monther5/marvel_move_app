import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  const TextForm(
      {super.key,
      required this.controller,
      required this.labelText,
      this.obscure,
      this.validator,
      this.suffixIcon, this.enabled});
  final TextEditingController controller;
  final String labelText;
  final bool? obscure;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
    final bool? enabled ;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled ?? true,
      controller: controller,
      validator: validator,
      obscureText: obscure ?? false,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    );
  }
}