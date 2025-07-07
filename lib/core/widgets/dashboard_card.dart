import 'package:flutter/material.dart';

import '../constants/app_color.dart' show AppColors;
import '../themes/text_scheme.dart' show MyTextTheme;

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.titleIcon,
    required this.cardTitle,
    required this.amount,
    required this.bottomContent,
  });

  final IconData titleIcon;
  final String cardTitle;
  final double amount;
  final String bottomContent;

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
        child: Column(
          children: [
            // Title row
            Row(
              children: [
                Icon(titleIcon, color: AppColors.secondary),
                SizedBox(width: 12),
                Flexible(
                  child: Text(
                    cardTitle,
                    style: MyTextTheme.lightTextTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            // Content row
            Row(
              children: [
                Flexible(
                  child: Text(
                    "RD\$ ${amount.toStringAsFixed(2)}",
                    style: MyTextTheme.lightTextTheme.displaySmall?.copyWith(
                      color: AppColors.primary,
                      fontSize: 25,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
              ],
            ),
            // Bottom row
            Row(
              children: [
                Text(
                  bottomContent,
                  style: MyTextTheme.lightTextTheme.labelSmall?.copyWith(
                    color: AppColors.textPrimary,
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
