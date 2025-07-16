import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool? readOnly;

  const CustomInputField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.obscureText = false,
    this.suffixIcon,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly ?? false,

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        hintText: hintText,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide.none, // Sin borde visible
        ),
        suffixIcon: suffixIcon,

      ),
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
