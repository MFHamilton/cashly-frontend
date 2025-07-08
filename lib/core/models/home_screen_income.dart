import 'package:intl/intl.dart';

class HomeScreenIncomeModel {
  final String frequency;
  final DateTime date;
  final double amount;

  HomeScreenIncomeModel({
    required this.frequency,
    required this.date,
    required this.amount,
  });

  factory HomeScreenIncomeModel.fromJson(Map<String, dynamic> json) {
    return HomeScreenIncomeModel(
      frequency: json['frequency'] ?? '',
      date: DateTime.parse(json['date']),
      amount: (json['amount'] ?? 0).toDouble(),
    );
  }

  String get formattedDay => DateFormat('YYYY-MM--dd').format(date);
}
