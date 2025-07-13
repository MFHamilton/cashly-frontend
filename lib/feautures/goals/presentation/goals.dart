import 'package:flutter/material.dart';

import '../../../core/services/goal_service.dart' show GoalService;
import '../../../core/themes/text_scheme.dart' show MyTextTheme;
import '../../../core/widgets/custom_button.dart' show CustomButton;
import '../../../core/widgets/goal_card.dart' show GoalCard;
import '../../../core/widgets/goal_list.dart' show GoalList;
import '../../../core/widgets/header.dart' show Header;
import '../../../core/widgets/menu.dart' show MenuLateralScreen;
import '../../../feautures/goals/data/models/goal.dart' show GoalModel;
import '../../../feautures/goals/data/models/goal_detail.dart'
    show GoalDetailModel;
import '../../../feautures/goals/presentation/add_goal.dart' show AddGoalScreen;

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  late Future<GoalDetailModel> goalDetailFuture;
  late Future<List<GoalModel>> goalsFuture;

  void loadGoals() {
    goalDetailFuture = GoalService.fetchGoalDetail();
    goalsFuture = GoalService.fetchGoals();
  }

  Future<void> navigateAddGoal() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddGoalScreen()),
    );

    if (result == true) {
      setState(loadGoals);
    }
  }

  @override
  void initState() {
    super.initState();
    loadGoals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuLateralScreen(),
      appBar: Header(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(width: 4),
                  Text("Metas", style: MyTextTheme.lightTextTheme.bodyLarge),
                ],
              ),
            ),
            // card general de metas
            FutureBuilder<GoalDetailModel>(
              future: goalDetailFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return GoalCard(
                    amount: data.amount,
                    percentageCompleted: data.percentageCompleted / 100,
                    date: data.date,
                  );
                } else {
                  return Text("Sin datos");
                }
              },
            ),
            // lista de cada meta
            FutureBuilder<List<GoalModel>>(
              future: goalsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return GoalList(metas: data);
                } else {
                  return Text("Sin datos");
                }
              },
            ),
            // boton para agregar meta
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: CustomButton(
                text: "+ Agregar Meta",
                style: 'primary',
                onPressed: navigateAddGoal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
