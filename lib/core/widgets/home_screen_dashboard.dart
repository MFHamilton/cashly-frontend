import 'package:flutter/material.dart';

import 'dashboard_card.dart' show DashboardCard;

class HomeScreenDashBoard extends StatelessWidget {
  const HomeScreenDashBoard({
    super.key,
    required this.incomeMonthlyAmount,
    required this.percentageIncome,
    required this.costsMonthlyAmount,
    required this.percentageCosts,
    required this.budgetUnused,
    required this.budgetAmount,
    required this.amountInGoal,
    required this.goalAmount,
  });

  final double incomeMonthlyAmount;
  final double percentageIncome;
  final double costsMonthlyAmount;
  final double percentageCosts;
  final double budgetUnused;
  final double budgetAmount;
  final double amountInGoal;
  final double goalAmount;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3 / 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        DashboardCard(
          titleIcon: Icons.trending_up,
          cardTitle: "Ingresos",
          amount: incomeMonthlyAmount,
          bottomContent:
              "${(percentageIncome * 100 > 0) ? '+${(percentageIncome * 100).toStringAsFixed(1)}' : '-${(percentageIncome * 100).toStringAsFixed(1)}'}% al mes anterior",
        ),

        DashboardCard(
          titleIcon: Icons.trending_down,
          cardTitle: "Gastos",
          amount: costsMonthlyAmount,
          bottomContent:
              "${percentageCosts * 100 > 0 ? "+${(percentageCosts * 100).toStringAsFixed(1)}" : "-${(percentageCosts * 100).toStringAsFixed(1)}"}% al mes anterior",
        ),

        DashboardCard(
          titleIcon: Icons.wallet,
          cardTitle: "Presupuesto",
          amount: budgetUnused,
          bottomContent: "de RD\$$budgetAmount",
        ),

        DashboardCard(
          titleIcon: Icons.credit_score,
          cardTitle: "Metas",
          amount: amountInGoal,
          bottomContent: "de RD\$$goalAmount",
        ),
      ],
    );
  }
}
