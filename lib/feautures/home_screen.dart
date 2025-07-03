import 'package:cashly/core/constants/app_color.dart';
import 'package:cashly/core/themes/text_scheme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                children: [
                  CustomCard(
                    titleIcon: Icons.arrow_circle_up_sharp,
                    cardTitle: "Ingresos",
                    amount: 30000,
                    bottomContent: "+5% al mes anterior",
                  ),

                  CustomCard(
                    titleIcon: Icons.account_circle_outlined,
                    cardTitle: "Gastos",
                    amount: 30000,
                    bottomContent: "+5% al mes anterior",
                  ),

                  CustomCard(
                    titleIcon: Icons.account_circle_outlined,
                    cardTitle: "Presupuesto",
                    amount: 30000,
                    bottomContent: "+5% al mes anterior",
                  ),

                  CustomCard(
                    titleIcon: Icons.account_circle_outlined,
                    cardTitle: "Metas",
                    amount: 30000,
                    bottomContent: "+5% al mes anterior",
                  ),
                ],
              ),
            ),
            // TODO: alertas
            // TODO: grafica de comparativa mensual
            Text(
              "Comparativa Mensual",
              style: MyTextTheme.lightTextTheme.titleLarge,
            ),
            MonthlyBarChart(),
            // TODO: fuente de ingresos
          ],
        ),
      ),
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
  const MonthlyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    const barColor = Color(0xFF003C1F); // Verde oscuro

    final data = [
      {'day': '21/03', 'amount': 50.0},
      {'day': '22/03', 'amount': 73.0},
      {'day': '23/03', 'amount': 35.0},
      {'day': '24/03', 'amount': 110.0},
      {'day': '25/03', 'amount': 90.0},
      {'day': '26/03', 'amount': 90.0},
      {'day': '27/03', 'amount': 25.0},
    ];

    return SizedBox(
      height: 220,
      child: BarChart(
        BarChartData(
          maxY: 120,
          minY: 0,
          alignment: BarChartAlignment.spaceAround,
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      data[value.toInt()]['day'].toString(),
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
            final value = item['amount'] as double;
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
                  rodStackItems: [],
                ),
              ],
              showingTooltipIndicators: [],
              barsSpace: 8,
            );
          }),
          extraLinesData: ExtraLinesData(horizontalLines: []),
          // barTouchTooltipData: BarTouchTooltipData(enabled: false),
          groupsSpace: 12,
        ),
        swapAnimationDuration: const Duration(milliseconds: 500),
        swapAnimationCurve: Curves.easeOut,
      ),
    );
  }
}
