
import 'package:flutter/material.dart';
import '';
import '../themes/button_theme.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({required this.text, required this.style, this.onPressed, super.key});

  final String text;
  final String style;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {

    final buttonStyle = style == 'primary'
        ? AppButtonTheme.primaryElevatedButtonStyle
        : AppButtonTheme.secondaryElevatedButtonStyle;

    return ElevatedButton(
        onPressed: onPressed ?? () {},
        style: buttonStyle,
        child: Text(text)

    );
  }
}
