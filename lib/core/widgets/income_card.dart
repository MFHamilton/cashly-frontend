import 'package:flutter/material.dart';

import '../constants/app_color.dart' show AppColors;
import '../themes/text_scheme.dart' show MyTextTheme;

class IncomeCard extends StatelessWidget {
  const IncomeCard({
    super.key,
    required this.frequency,
    required this.date,
    required this.amount,
  });

  final String frequency;
  final String date;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Bordes redondeados
      ),
      color: Colors.grey[300],
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Salario $frequency",
                  style: MyTextTheme.lightTextTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  date,
                  style: MyTextTheme.lightTextTheme.bodySmall?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            Spacer(),
            // cantidad
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "+RD\$$amount",
                  style: MyTextTheme.lightTextTheme.bodyLarge?.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Salario",
                    style: MyTextTheme.lightTextTheme.bodyMedium?.copyWith(
                      color: AppColors.background,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}