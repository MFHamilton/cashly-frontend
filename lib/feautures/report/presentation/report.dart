import 'package:cashly/core/widgets/header.dart';
import 'package:cashly/core/widgets/menu.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/themes/text_scheme.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuLateralScreen(),
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titulo de la pantalla
            Container(
              width: 175,
              padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(width: 4),
                  Text(
                    "Reportes Financieros",
                    style: MyTextTheme.lightTextTheme.bodyLarge,
                  ),
                ],
              ),
            ),

            ExportButtons(),

            // TODO: distribucion de gastos
            GastosPieChart(),
            // TODO: reportes
            VistaReporte(),
            // TODO: progreso de metas
            GoalProgressCard(),
          ],
        ),
      ),
    );
  }
}

class ExportButtons extends StatelessWidget {
  const ExportButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _smallOutlinedButton(
          onPressed: () {},
          icon: Icons.calendar_today,
          label: "Este mes",
          trailingIcon: Icons.arrow_drop_down,
        ),
        const SizedBox(width: 8),
        _smallOutlinedButton(
          onPressed: () {},
          icon: Icons.insert_drive_file,
          label: "Exportar Excel",
        ),
        const SizedBox(width: 8),
        _smallOutlinedButton(
          onPressed: () {},
          icon: Icons.download,
          label: "Descargar PDF",
        ),
      ],
    );
  }

  Widget _smallOutlinedButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    IconData? trailingIcon,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.green),
        foregroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: const TextStyle(fontSize: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.green),
          const SizedBox(width: 4),
          Text(label),
          if (trailingIcon != null) ...[
            const SizedBox(width: 4),
            Icon(trailingIcon, size: 16, color: Colors.green),
          ],
        ],
      ),
    );
  }
}

class GastosPieChart extends StatelessWidget {
  const GastosPieChart({super.key});

  final List<Color> sectionColors = const [
    Color(0xFFDCE7E2), // Comida
    Color(0xFF007F3F), // Servicios
    Color(0xFF00D084), // Transporte
    Color(0xFFE1ECE9), // Entretenimiento
  ];

  final List<Map<String, dynamic>> data = const [
    {'label': 'Comida', 'value': 38.0, 'amount': 3200},
    {'label': 'Servicios', 'value': 29.0, 'amount': 2500},
    {'label': 'Transporte', 'value': 21.0, 'amount': 1800},
    {'label': 'Entretenimiento', 'value': 12.0, 'amount': 1000},
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Encabezado
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Distribución de Gastos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download, size: 16),
                  label: const Text("Gráfico"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.green,
                    side: const BorderSide(color: Colors.green),
                    textStyle: const TextStyle(fontSize: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Gráfico
            SizedBox(
              height: 160,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 50,
                  sectionsSpace: 2,
                  sections:
                      data.asMap().entries.map((entry) {
                        int index = entry.key;
                        final item = entry.value;
                        return PieChartSectionData(
                          color: sectionColors[index],
                          value: item['value'],
                          showTitle: false,
                          radius: 40,
                        );
                      }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Leyenda
            Column(
              children:
                  data.asMap().entries.map((entry) {
                    int index = entry.key;
                    final item = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: sectionColors[index],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item['label'],
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ),
                          Text(
                            "${item['value'].toInt()}% (\$${item['amount']})",
                            style: const TextStyle(color: Colors.black45),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class VistaReporte extends StatelessWidget {
  const VistaReporte({super.key});

  @override
  Widget build(BuildContext context) {
    final filtros = ["Ingresos", "Categoría", "Mes", "Año"];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Reportes",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "Previsualiza tu reporte antes de descargarlo",
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 16),

          // Filtros
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children:
                filtros
                    .map(
                      (e) => SizedBox(
                        width: 120,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.green,
                            side: const BorderSide(color: Colors.green),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(e, style: const TextStyle(fontSize: 13)),
                              const Icon(Icons.arrow_drop_down, size: 20),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),

          const SizedBox(height: 24),

          // Reporte
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Color.fromARGB(20, 0, 0, 0), blurRadius: 6),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ingresos Totales - Trabajo - Julio 2025",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Resumen",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text("Total de ingresos:  DOP\$15,000"),
                const Text("Transacciones registradas: 2"),
                const Text("Frecuencia: Quincenal"),
                const SizedBox(height: 16),
                const Text(
                  "Detalle",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Tabla simple
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Fecha",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Monto",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Expanded(child: Text("02/07/2025")),
                    Expanded(child: Text("5,000")),
                  ],
                ),
                const Row(
                  children: [
                    Expanded(child: Text("02/07/2025")),
                    Expanded(child: Text("5,000")),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Botones de exportar
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.file_copy_outlined, size: 16),
                label: const Text("Exportar Excel"),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                  side: const BorderSide(color: Colors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download, size: 14),
                label: const Text(
                  "Descargar PDF",
                  style: TextStyle(fontSize: 12),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                  side: const BorderSide(color: Colors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  textStyle: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Goal {
  final String name;
  final double progress; // entre 0.0 y 1.0

  Goal(this.name, this.progress);
}

class GoalProgressCard extends StatelessWidget {
  final List<Goal> goals = [
    Goal('Fondo de Emergencia', 0.64),
    Goal('Vacaciones', 0.89),
    Goal('Tarjeta', 1.0),
    Goal('Casa Nueva', 0.80),
  ];

  GoalProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progreso de Metas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...goals.map((goal) => GoalProgress(goal: goal)).toList(),
          ],
        ),
      ),
    );
  }
}

class GoalProgress extends StatelessWidget {
  final Goal goal;

  const GoalProgress({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final percentage = (goal.progress * 100).round();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(goal.name, style: const TextStyle(color: Colors.grey)),
              Text('$percentage%', style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: goal.progress,
            minHeight: 6,
            borderRadius: BorderRadius.circular(8),
            backgroundColor: Colors.grey[300],
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
