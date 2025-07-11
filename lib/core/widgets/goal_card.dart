import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({
    super.key,
    required this.amount,
    required this.percentageCompleted,
    required this.date,
  });

  final double amount;
  final double percentageCompleted;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    String monthYear = DateFormat("MMMM yyyy", "es").format(date);
    monthYear = "${monthYear[0].toUpperCase()}${monthYear.substring(1)}";

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: icon + title + badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.attach_money, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(
                      "Mis metas",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.green[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[900],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    monthYear,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Amount
            Center(
              child: Text(
                "RD\$${NumberFormat("#,##0.00", "en_US").format(amount)}",
                style:
                    amount < 1000000
                        ? Theme.of(context).textTheme.displayLarge
                        : Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 16),

            // Circular progress indicator
            Center(
              child: CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 12.0,
                percent: percentageCompleted,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${NumberFormat("#,##0.0", "en_US").format(percentageCompleted * 100)}%",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text("Completado", style: TextStyle(fontSize: 12)),
                  ],
                ),
                backgroundColor: Colors.green[100]!,
                progressColor: Colors.green[600],
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
