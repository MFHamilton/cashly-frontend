import 'package:intl/intl.dart';

class HomeScreenChartModel {
  final DateTime day;
  final double amount;

  HomeScreenChartModel({
    required this.day,
    required this.amount,
  });

  factory HomeScreenChartModel.fromJson(Map<String, dynamic> json) {
    return HomeScreenChartModel(
      day: DateTime.parse(json['day']),
      amount: (json['amount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day.toIso8601String(),
      'amount': amount,
    };
  }

  String get formattedDay => DateFormat('dd/MM').format(day);
}
