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
        borderRadius: BorderRadius.circular(3), // Bordes redondeados
      ),
      color: Theme.of(context).colorScheme.primaryContainer,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // Title row
            Row(
              children: [
                Icon(titleIcon, color: AppColors.secondary),
                SizedBox(width: 5),
                Flexible(
                  child: Text(
                    cardTitle,
                    style: MyTextTheme.lightTextTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            // Content row
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "RD\$ ${amount.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,

                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),

                Text(
                  bottomContent,
                  style: MyTextTheme.lightTextTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
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
