import 'package:flutter/material.dart';

class SavingGoalCard extends StatelessWidget {
  const SavingGoalCard({
    super.key,
    required this.currentAmount,
    required this.goalAmount,
    required this.name,
    required this.category,
    this.description,
  });

  final double currentAmount;
  final double goalAmount;
  final String name;
  final String category;
  final String? description;

  @override
  Widget build(BuildContext context) {
    double percent = currentAmount / goalAmount;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
                    SizedBox(width: 12),
                    Icon(Icons.delete, color: Theme.of(context).colorScheme.primary),
                  ],
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(category, style: TextStyle(color: Colors.grey)),

            SizedBox(height: 12),
            (description != null && description != "")
                ? Column(
                  children: [
                    Text(
                      description!,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                )
                : SizedBox(height: 0),

            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: percent,
                minHeight: 14,
                backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
              ),
            ),

            const SizedBox(height: 8),

            // Amounts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${currentAmount.toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  "de \$${goalAmount.toStringAsFixed(2)}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
