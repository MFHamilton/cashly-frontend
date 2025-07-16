import 'package:cashly/core/models/presupuestos.dart';
import 'package:cashly/core/services/goal_service.dart';
import 'package:cashly/feautures/goals/data/models/goal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:cashly/core/models/gastos.dart';
import 'package:cashly/core/services/gastos_service.dart';
import 'package:cashly/core/widgets/header.dart';
import 'package:cashly/core/widgets/menu.dart';
import '../../../core/themes/text_scheme.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late Future<List<Gastos>> gastosFuture;
  late Future<List<GoalModel>> goalsFuture;

  final List<GoalModel> goalsList = [
    GoalModel(
      metaEsActivo: true,
      metaId: 1,
      metaMontoInicial: 500,
      metaNombre: "meta",
      fechaInicio: DateTime.now(),
      metaDescripcion: "",
      fechaFin: DateTime.now(),
      metaMontoUlt: 350,
      usuarioId: 1,
      categoriaId: 1,
      periodoId: 1,
      categoriaNom: "Comida",
    ),
    GoalModel(
      metaEsActivo: true,
      metaId: 1,
      metaMontoInicial: 1500,
      metaNombre: "meta",
      fechaInicio: DateTime.now(),
      metaDescripcion: "",
      fechaFin: DateTime.now(),
      metaMontoUlt: 1000,
      usuarioId: 1,
      categoriaId: 1,
      periodoId: 1,
      categoriaNom: "Viaje",
    ),
  ];

  GastosService _gastosService = GastosService();

  @override
  void initState() {
    super.initState();
    gastosFuture = _gastosService.fetchGastos();
    goalsFuture = GoalService.fetchGoals();
  }

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
            // ExportButtons(),
            // distribucion de gastos
            FutureBuilder<List<Gastos>>(
              future: gastosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return GastosPieChart(gastos: data);
                } else {
                  return Text("Sin datos");
                }
              },
            ),
            // TODO: reportes
            VistaReporte(),
            // progreso de metas
            FutureBuilder<List<GoalModel>>(
              future: goalsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return GoalProgressCard(goalsList: data);
                } else {
                  return Text("Sin datos");
                }
              },
            ),
            // GoalProgressCard(goalsList: goalsList),
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
  const GastosPieChart({super.key, required this.gastos});

  final List<Color> sectionColors = const [
    Color(0xFFDCE7E2), // Comida
    Color(0xFF007F3F), // Servicios
    Color(0xFF00D084), // Transporte
    Color(0xFFE1ECE9), // Entretenimiento
  ];

  final List<Gastos> gastos;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = [];
    double gastoTotal = 0;
    for (var gasto in gastos) {
      gastoTotal += gasto.gastoMonto;

      String categoriaNom =
          (gasto.categoriaNom?.isEmpty ?? true) ? "Otros" : gasto.categoriaNom!;

      Map<String, dynamic>? existente = data.firstWhere(
        (item) => item['label'] == categoriaNom,
        orElse: () => {},
      );

      if (existente.isNotEmpty) {
        existente['amount'] += gasto.gastoMonto;
      } else {
        data.add({'label': categoriaNom, 'amount': gasto.gastoMonto});
      }
    }

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
                      data.asMap().entries.map((gasto) {
                        int index = gasto.key;
                        final item = gasto.value;
                        return PieChartSectionData(
                          color: sectionColors[index],
                          value: item['amount'] * 100 / gastoTotal,
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
                            "${item['amount'] * 100 / gastoTotal}% (\$${item['amount']})",
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

class VistaReporte extends StatefulWidget {
  const VistaReporte({super.key});

  @override
  State<VistaReporte> createState() => _VistaReporteState();
}

class _VistaReporteState extends State<VistaReporte> {
  // Mock data para los selectores
  final List<String> tipos = ['Ingresos', 'Gastos'];
  final List<String> categorias = [
    'Todas',
    'Comida',
    'Transporte',
    'Servicios',
    'Otros',
  ];
  final List<String> meses = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre',
  ];
  final List<String> anios = ['2023', '2024', '2025'];

  // Valores seleccionados
  String selectedTipo = 'Ingresos';
  String selectedCategoria = 'Todas';
  String selectedMes = 'Julio';
  String selectedAnio = '2025';

  @override
  Widget build(BuildContext context) {
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

          // Filtros como dropdowns
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildDropdown("Tipo", selectedTipo, tipos, (value) {
                setState(() => selectedTipo = value);
              }),
              _buildDropdown("Categoría", selectedCategoria, categorias, (
                value,
              ) {
                setState(() => selectedCategoria = value);
              }),
              _buildDropdown("Mes", selectedMes, meses, (value) {
                setState(() => selectedMes = value);
              }),
              _buildDropdown("Año", selectedAnio, anios, (value) {
                setState(() => selectedAnio = value);
              }),
            ],
          ),

          const SizedBox(height: 24),

          // Reporte simulado
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
              children: const [
                Text(
                  "Ingresos Totales - Trabajo - Julio 2025",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text("Resumen", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Total de ingresos:  DOP\$15,000"),
                Text("Transacciones registradas: 2"),
                Text("Frecuencia: Quincenal"),
                SizedBox(height: 16),
                Text("Detalle", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),

                // Tabla simple
                Row(
                  children: [
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
                SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(child: Text("02/07/2025")),
                    Expanded(child: Text("5,000")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text("16/07/2025")),
                    Expanded(child: Text("10,000")),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Botones de exportación
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.file_copy_outlined, size: 16),
                label: const Text("Exportar Excel"),
                style: _buttonStyle(),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download, size: 14),
                label: const Text("Descargar PDF"),
                style: _buttonStyle(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Dropdown builder
  Widget _buildDropdown(
    String label,
    String selectedValue,
    List<String> items,
    ValueChanged<String> onChanged,
  ) {
    return SizedBox(
      width: 80, // 👈 Más pequeño para que quepan más
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 11),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 6,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          isDense: true,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValue,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down, size: 18),
            iconSize: 18,
            dropdownColor: Colors.white,
            onChanged: (String? newValue) {
              if (newValue != null) onChanged(newValue);
            },
            items:
                items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(fontSize: 12)),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }

  // Botón de exportar estilo
  ButtonStyle _buttonStyle() {
    return OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.green,
      side: const BorderSide(color: Colors.green),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      textStyle: const TextStyle(fontSize: 13),
    );
  }
}

class GoalProgressCard extends StatelessWidget {
  final List<GoalModel> goalsList;

  const GoalProgressCard({super.key, required this.goalsList});

  @override
  Widget build(BuildContext context) {
    List<GoalModel> goals =
        goalsList
            .where(
              (g) =>
                  g.fechaFin == null ||
                  g.fechaFin!.month >= DateTime.now().month,
            )
            .toList();
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
  final GoalModel goal;

  const GoalProgress({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final percentage =
        ((goal.metaMontoUlt ?? 0) / goal.metaMontoInicial * 100).round();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(goal.metaNombre, style: const TextStyle(color: Colors.grey)),
              Text('$percentage%', style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: percentage / 100,
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
