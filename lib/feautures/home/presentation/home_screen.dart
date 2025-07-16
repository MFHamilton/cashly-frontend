import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants/app_color.dart' show AppColors;
import '../models/home_screen_chart.dart' show HomeScreenChartModel;

class MonthlyBarChart extends StatelessWidget {
  const MonthlyBarChart({super.key, required this.data});

  final List<HomeScreenChartModel> data;

  @override
  Widget build(BuildContext context) {
    const barColor = AppColors.primary;

    // 1) Calcula el valor máximo de todos los montos
    final rawMax = data.isNotEmpty
        ? data.map((e) => e.amount).reduce(max)
        : 0.0;

    // 2) Añade un colchón del 20% para que la barra no toque el tope
    final maxY = rawMax * 1.2;

    // En caso de que tu rawMax sea cero (no datos), fiaj un mínimo razonable
    final chartMaxY = maxY > 0 ? maxY : 1.0;

    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          BarChart(
            BarChartData(
              maxY: chartMaxY,
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
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      final idx = value.toInt();
                      if (idx < 0 || idx >= data.length) return const SizedBox();
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          data[idx].formattedDay,
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(data.length, (index) {
                final val = data[index].amount;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: val,
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

          // Valores sobre cada barra
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: data.map((item) {
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
