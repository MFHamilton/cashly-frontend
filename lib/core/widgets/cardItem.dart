import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CardItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(Icons.arrow_upward, color: Color(0xFFB5D4B1)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.titleSmall),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(amount,
                style: Theme.of(context).textTheme.titleMedium?.copyWith()),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.secondary),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.secondary),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}