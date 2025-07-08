class HomeScreenDashboardModel {
  final double incomeMonthlyAmount;
  final double percentageIncome;
  final double costsMonthlyAmount;
  final double percentageCosts;
  final double budgetUnused;
  final double budgetAmount;
  final double amountInGoal;
  final double goalAmount;

  HomeScreenDashboardModel({
    required this.incomeMonthlyAmount,
    required this.percentageIncome,
    required this.costsMonthlyAmount,
    required this.percentageCosts,
    required this.budgetUnused,
    required this.budgetAmount,
    required this.amountInGoal,
    required this.goalAmount,
  });

  factory HomeScreenDashboardModel.fromJson(Map<String, dynamic> json) {
    return HomeScreenDashboardModel(
      incomeMonthlyAmount: (json['incomeMonthlyAmount'] ?? 0).toDouble(),
      percentageIncome: (json['percentageIncome'] ?? 0).toDouble(),
      costsMonthlyAmount: (json['costsMonthlyAmount'] ?? 0).toDouble(),
      percentageCosts: (json['percentageCosts'] ?? 0).toDouble(),
      budgetUnused: (json['budgetUnused'] ?? 0).toDouble(),
      budgetAmount: (json['budgetAmount'] ?? 0).toDouble(),
      amountInGoal: (json['amountInGoal'] ?? 0).toDouble(),
      goalAmount: (json['goalAmount'] ?? 0).toDouble(),
    );
  }
}
