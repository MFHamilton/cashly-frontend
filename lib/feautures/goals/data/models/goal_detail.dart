class GoalDetailModel {
  final double amount;
  final double percentageCompleted;
  final DateTime date;

  GoalDetailModel({
    required this.amount,
    required this.percentageCompleted,
    required this.date,
  });

  factory GoalDetailModel.fromJson(Map<String, dynamic> json) {
    return GoalDetailModel(
      amount: double.parse(json['amount']),
      percentageCompleted: double.parse(json['percentageCompleted']),
      date: DateTime.parse(json['date']),
    );
  }
}