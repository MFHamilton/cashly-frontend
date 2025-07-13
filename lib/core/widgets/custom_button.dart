
import 'package:flutter/material.dart';
import '';


class CustomButton extends StatelessWidget {
  const CustomButton({required this.text, this.onPressed, required this.style, super.key});

  final String text;
  final String style;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed ?? () {},
        style: style == 'primary'
            ? Theme.of(context).elevatedButtonTheme.style
            : Theme.of(context).elevatedButtonTheme.style,

    );
  }
}
