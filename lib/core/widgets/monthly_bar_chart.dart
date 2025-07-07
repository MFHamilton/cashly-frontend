import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants/app_color.dart';
import '../models/home_screen_chart.dart';

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