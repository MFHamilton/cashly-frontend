import 'package:flutter/material.dart';

class SavingGoalCard extends StatelessWidget {
  const SavingGoalCard({
    super.key,
    required this.currentAmount,
    required this.goalAmount,
    required this.name,
    required this.category,
  });

  final double currentAmount;
  final double goalAmount;
  final String name;
  final String category;

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
                  children: const [
                    Icon(Icons.edit, color: Colors.green),
                    SizedBox(width: 12),
                    Icon(Icons.delete, color: Colors.green),
                  ],
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(category, style: TextStyle(color: Colors.grey)),

            SizedBox(height: 12),
            Text(
              "Ahorrar para gastos inesperados",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 16),

            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: percent,
                minHeight: 14,
                backgroundColor: Colors.green[100],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green[600]!),
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