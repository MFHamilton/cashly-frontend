
import 'package:flutter/material.dart';
import '';


class CustomButton extends StatelessWidget {
  const CustomButton({required this.text, this.onPressed,super.key});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed ?? () {},
        style: Theme.of(context).elevatedButtonTheme.style,
        child: Text(
          text,
          //style: Theme.of(context).textTheme.bodyMedium,
        )
    );
  }
}
