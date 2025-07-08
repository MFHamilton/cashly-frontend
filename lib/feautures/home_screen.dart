import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/app_color.dart' show AppColors;
import '../core/models/dashboard.dart' show HomeScreenDashboardModel;
import '../core/models/home_screen_chart.dart' show HomeScreenChartModel;
import '../core/models/home_screen_income.dart' show HomeScreenIncomeModel;
import '../core/services/home_screen_service.dart' show HomeScreenService;
import '../core/themes/text_scheme.dart' show MyTextTheme;
import '../core/widgets/home_screen_dashboard.dart' show HomeScreenDashBoard;
import '../core/widgets/income_list.dart' show IncomeList;
import '../core/widgets/monthly_bar_chart.dart' show MonthlyBarChart;

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