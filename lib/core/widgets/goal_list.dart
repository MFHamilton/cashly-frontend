import 'package:flutter/material.dart';

import '../../feautures/goals/data/models/goal.dart' show GoalModel;
import './saving_goal_card.dart' show SavingGoalCard;

class GoalList extends StatelessWidget {
  const GoalList({super.key, required this.metas});

  final List<GoalModel> metas;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // si está dentro de otro scroll
      physics: NeverScrollableScrollPhysics(), // evita scroll si anidado
      itemCount: metas.length,
      itemBuilder: (context, index) {
        final meta = metas[index];
        return SavingGoalCard(
          currentAmount: meta.metaMontoUlt ?? 0.0,
          goalAmount: meta.metaMontoInicial,
          name: meta.metaNombre,
          category: meta.categoriaNom ?? "",
        );
      },
    );
  }
}