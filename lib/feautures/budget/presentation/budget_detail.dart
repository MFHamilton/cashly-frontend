import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'add_budget.dart';
import '../../../core/models/presupuestos.dart';
import '../../../core/themes/text_scheme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/header.dart';
import '../../../core/widgets/menu.dart';

class BudgetDetailScreen extends StatefulWidget {
  const BudgetDetailScreen({super.key, required this.budget});

  final Presupuestos budget;

  @override
  State<BudgetDetailScreen> createState() => _BudgetDetailScreenState();
}

class _BudgetDetailScreenState extends State<BudgetDetailScreen> {
  int option = 1;

  void changeTo(int number) {
    setState(() {
      option = number;
    });
  }

  void navigate() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBudgetScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: navigate,
        child: Icon(Icons.edit_outlined),
      ),
      drawer: MenuLateralScreen(),
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // titulo de pantalla
            Container(
              width: 110,
              padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(width: 4),
                  Text(
                    "Presupesto",
                    style: MyTextTheme.lightTextTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            // card con el detalle del presupuesto
            BudgetDetailCard(presupuesto: widget.budget),
            // opciones de resumen, historial y análisis
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 90,
                      height: 50,
                      child: CustomButton(
                        text: "Resumen",
                        style: "primary",
                        onPressed: () => changeTo(1),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 90,
                      height: 50,
                      child: CustomButton(
                        text: "Historial",
                        style: "primary",
                        onPressed: () => changeTo(2),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 90,
                      height: 50,
                      child: CustomButton(
                        text: "Análisis",
                        style: "primary",
                        onPressed: () => changeTo(3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // renderizar resumen, historial o análisis
            if (option == 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Summary(),
              ),
            if (option == 2)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: History(),
              ),
            if (option == 3)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: MonthProjection(),
              ),
          ],
        ),
      ),
    );
  }
}

// TODO: componente de card de detalles
class BudgetDetailCard extends StatelessWidget {
  final Presupuestos presupuesto;

  const BudgetDetailCard({super.key, required this.presupuesto});

  @override
  Widget build(BuildContext context) {
    final restante = presupuesto.presMontoInicial - presupuesto.presMontoUlt;
    final porcentajeGastado =
        presupuesto.presMontoUlt / presupuesto.presMontoInicial;
    final diasTotales =
        presupuesto.finRecurrencia
            ?.difference(presupuesto.inicioRecurrencia!)
            .inDays;
    final diasActuales =
        DateTime.now().difference(presupuesto.inicioRecurrencia!).inDays + 1;

    final currency = NumberFormat.currency(symbol: "\$", decimalDigits: 0);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    presupuesto.presNombre,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    presupuesto.categoriaNom ?? "",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Montos
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Restante
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currency.format(restante),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "de ${currency.format(presupuesto.presMontoInicial)}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              // Gastado
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    currency.format(presupuesto.presMontoUlt),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${(porcentajeGastado * 100).toStringAsFixed(0)}% usado",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progreso del periodo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Progreso del periodo",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                "$diasActuales de ${diasTotales ?? '--'} días",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Barra de progreso
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              minHeight: 12,
              value: porcentajeGastado.clamp(0.0, 1.0),
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}

// TODO: componente de resumen
class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// TODO: componente de historial
class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Transacciones Recientes");
  }
}

// TODO: componente de análisis de proyección del mes
class MonthProjection extends StatelessWidget {
  const MonthProjection({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Proyección del Mes");
  }
}
