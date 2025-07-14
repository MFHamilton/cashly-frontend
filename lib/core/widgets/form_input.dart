import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final String title;
  final IconData? icon;
  final TextInputType? keyboardType;
  final String? prefixText;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final Function()? onTap;


  const FormInput({
    super.key,
    required this.inputController,
    this.hintText = '',
    this.title = '',
    this.icon,
    this.keyboardType,
    this.prefixText,
    this.validator,
    this.maxLength,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Row(
              children: [
                if (icon != null)
                  Icon(icon, color: Theme.of(context).colorScheme.primary),
                if (icon != null)
                  SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          SizedBox(height: 8),
          TextFormField(
            controller: inputController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              hintText: hintText,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary, // o cualquier otro color
                  //width: 1.5, // ancho opcional
                ),
              ),

            ),
            style: Theme.of(context).textTheme.bodySmall,
            onTap: onTap,
          ),
        ],
      ),

    );
  }
}

