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
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.arrow_upward, color: Color(0xFFB5D4B1)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),
            Text(amount,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: onEdit,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 20),
              onPressed: onDelete,
              padding: const EdgeInsets.only(left: 4),
              constraints: const BoxConstraints(),
              splashRadius: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
