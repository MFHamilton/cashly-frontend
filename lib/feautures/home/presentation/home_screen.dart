import 'package:cashly/core/constants/app_color.dart';
import 'package:cashly/core/models/dashboard.dart';
import 'package:cashly/core/themes/text_scheme.dart';
import 'package:cashly/core/widgets/menu.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/models/home_screen_chart.dart';
import '../../../core/models/home_screen_income.dart';
import '../../../core/services/home_screen_service.dart';
import '../../../core/widgets/header.dart';
import '../../../core/widgets/home_screen_dashboard.dart';
import '../../../core/widgets/income_list.dart';
import '../../../core/widgets/monthly_bar_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<HomeScreenDashboardModel> dashboardFuture;
  late Future<List<HomeScreenChartModel>> chartFuture;
  late Future<List<HomeScreenIncomeModel>> incomeFuture;

  @override
  void initState() {
    super.initState();
    dashboardFuture = HomeScreenService.fetchDashboardData();
    chartFuture = HomeScreenService.fetchChartData();
    incomeFuture = HomeScreenService.fetchIncomeList();
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
            //Header(),
            // TODO: probar el endpoint dashboard
            FutureBuilder<HomeScreenDashboardModel>(
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
