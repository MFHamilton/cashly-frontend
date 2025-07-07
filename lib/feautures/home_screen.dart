import 'package:cashly/core/constants/app_color.dart';
import 'package:cashly/core/models/dashboard.dart';
import 'package:cashly/core/models/home_screen_income.dart';
import 'package:cashly/core/models/home_screen_chart.dart';
import 'package:cashly/core/themes/text_scheme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/services/dashboard_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<DashboardModel> dashboardFuture;
  late Future<List<HomeScreenChartModel>> chartFuture;
  late Future<List<HomeScreenIncomeModel>> incomeFuture;

  final incomeData = [
    {"frecuencia": "Mensual", "fecha": "12-06-2025", "amount": 30000},
    {"frecuencia": "Mensual", "fecha": "12-06-2025", "amount": 30000},
    {"frecuencia": "Mensual", "fecha": "12-06-2025", "amount": 30000},
    {"frecuencia": "Mensual", "fecha": "12-06-2025", "amount": 30000},
    {"frecuencia": "Mensual", "fecha": "12-06-2025", "amount": 30000},
  ];

  @override
  void initState() {
    super.initState();
    dashboardFuture = DashboardService.fetchDashboardData();
    chartFuture = DashboardService.fetchChartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: Stack(
            children: [
              // Botón izquierdo
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    // Acción del botón izquierdo
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Menú presionado")),
                    );
                  },
                  color: AppColors.primary,
                ),
              ),
              // Imagen centrada
              Center(
                child: SvgPicture.asset(
                  'assets/logotype/whiteLogo.svg',
                  color: AppColors.secondary,
                  width: 100,
                ),
              ),
              // Botón derecho
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.account_circle_outlined),
                  onPressed: () {
                    // Acción del botón derecho
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Perfil presionado")),
                    );
                  },
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: probar el endpoint dashboard
            FutureBuilder<DashboardModel>(
              future: dashboardFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return HomeScreenDashBoard(
                    incomeMonthlyAmount: data.incomeMonthlyAmount,
                    percentageIncome: data.percentageIncome,
                    costsMonthlyAmount: data.costsMonthlyAmount,
                    percentageCosts: data.percentageCosts,
                    budgetUnused: data.budgetUnused,
                    budgetAmount: data.budgetAmount,
                    amountInGoal: data.amountInGoal,
                    goalAmount: data.goalAmount,
                  );
                } else {
                  return Text("Sin datos");
                }
              },
            ),
            // TODO: alertas
            // Gráfica de comparativa mensual
            Text(
              "Comparativa Mensual",
              style: MyTextTheme.lightTextTheme.titleLarge,
            ),
            // TODO: probar endpoint integrado
            FutureBuilder<List<HomeScreenChartModel>>(
              future: chartFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return MonthlyBarChart(data: data);
                } else {
                  return Text("Sin datos");
                }
              },
            ),
            // fuente de ingresos
            SizedBox(height: 20),
            Text(
              "Fuentes de Ingresos",
              style: MyTextTheme.lightTextTheme.titleLarge,
            ),
            FutureBuilder<List<HomeScreenIncomeModel>>(
              future: incomeFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return IncomeList(data: data);
                } else {
                  return Text("Sin datos");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
        CustomCard(
          titleIcon: Icons.trending_up,
          cardTitle: "Ingresos",
          amount: incomeMonthlyAmount,
          bottomContent:
              "${percentageIncome * 100 > 0 ? '+${percentageIncome * 100}' : '-${percentageIncome * 100}'}% al mes anterior",
        ),

        CustomCard(
          titleIcon: Icons.trending_down,
          cardTitle: "Gastos",
          amount: costsMonthlyAmount,
          bottomContent:
              "${percentageCosts * 100 > 0 ? "+${percentageCosts * 100}" : "-${percentageCosts * 100}"}% al mes anterior",
        ),

        CustomCard(
          titleIcon: Icons.wallet,
          cardTitle: "Presupuesto",
          amount: budgetUnused,
          bottomContent: "de RD\$$budgetAmount",
        ),

        CustomCard(
          titleIcon: Icons.credit_score,
          cardTitle: "Metas",
          amount: amountInGoal,
          bottomContent: "de RD\$$goalAmount",
        ),
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
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

class MonthlyBarChart extends StatelessWidget {
  const MonthlyBarChart({super.key, required this.data});

  final List<HomeScreenChartModel> data;

  @override
  Widget build(BuildContext context) {
    const barColor = AppColors.primary;

    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          BarChart(
            BarChartData(
              maxY: 120,
              minY: 0,
              alignment: BarChartAlignment.spaceAround,
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          data[value.toInt()].formattedDay,
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    },
                    reservedSize: 30,
                  ),
                ),
              ),
              barGroups: List.generate(data.length, (index) {
                final item = data[index];
                final value = item.amount;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: value,
                      color: barColor,
                      width: 16,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    ),
                  ],
                );
              }),
              groupsSpace: 12,
            ),
            swapAnimationDuration: const Duration(milliseconds: 500),
            swapAnimationCurve: Curves.easeOut,
          ),
          // Añadir valores sobre las barras con Positioned widgets
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    data.map((item) {
                      return Expanded(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            '\$${item.amount.toString()}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF003C1F),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

class IncomeCard extends StatelessWidget {
  const IncomeCard({
    super.key,
    required this.frequency,
    required this.date,
    required this.amount,
  });

  final String frequency;
  final String date;
  final double amount;

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
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12),
            // TODO: salario mensual y fecha
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Salario $frequency",
                  style: MyTextTheme.lightTextTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  date,
                  style: MyTextTheme.lightTextTheme.bodySmall?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            Spacer(),
            // cantidad
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "+RD\$$amount",
                  style: MyTextTheme.lightTextTheme.bodyLarge?.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Salario",
                    style: MyTextTheme.lightTextTheme.bodyMedium?.copyWith(
                      color: AppColors.background,
                    ),
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
