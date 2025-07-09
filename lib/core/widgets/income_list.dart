import 'package:flutter/material.dart';

import '../models/home_screen_income.dart' show HomeScreenIncomeModel;
import 'income_card.dart' show IncomeCard;

class IncomeList extends StatelessWidget {
  const IncomeList({super.key, required this.data});

  final List<HomeScreenIncomeModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return IncomeCard(
          frequency: item.frequency,
          date: item.toString(),
          amount: item.amount,
        );
      },
    );
  }
}