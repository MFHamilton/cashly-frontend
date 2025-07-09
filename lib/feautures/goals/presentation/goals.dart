import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/widgets/header.dart';
import '../../../core/themes/text_scheme.dart';
import '../../../core/widgets/custom_button.dart';

// ignore: must_be_immutable
class GoalsScreen extends StatelessWidget {
  GoalsScreen({super.key});

  List<Map<String, dynamic>> metas = [
    {
      'currentAmount': 6500.0,
      'goalAmount': 10000.0,
      'name': 'Fondo de emergencias',
      'category': 'Emergencia',
    },
    {
      'currentAmount': 300,
      'goalAmount': 10000.0,
      'name': 'Vacaciones',
      'category': 'Entretenimiento',
    },
    {
      'currentAmount': 6500.0,
      'goalAmount': 10000.0,
      'name': 'Algo',
      'category': 'Emergencia',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // boton para ir al home page
            Container(
              width: 80,
              padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: InkWell(
                onTap: () {
                  if (kDebugMode) {
                    print("Ir al home page");
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios),
                    SizedBox(width: 4),
                    Text("Metas", style: MyTextTheme.lightTextTheme.bodyLarge),
                  ],
                ),
              ),
            ),
            // card general de metas
            GoalCard(
              amount: 9365700,
              percentageCompleted: 0.55,
              date: DateTime(2025, 7, 2),
            ),
            // lista de cada meta
            ListView.builder(
              shrinkWrap: true, // si está dentro de otro scroll
              physics:
                  NeverScrollableScrollPhysics(), // evita scroll si anidado
              itemCount: metas.length,
              itemBuilder: (context, index) {
                final meta = metas[index];
                return SavingGoalCard(
                  currentAmount: meta['currentAmount'],
                  goalAmount: meta['goalAmount'],
                  name: meta['name'],
                  category: meta['category'],
                );
              },
            ),
            // boton para agregar meta
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: CustomButton(
                text: "+ Agregar Meta",
                onPressed: () {
                  // TODO: viajar a la pantalla de creación de meta
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
                style: Theme.of(context).textTheme.displayLarge,
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
