import 'package:flutter/material.dart';

import 'add_budget.dart';
import '../../../core/models/presupuestos.dart';
import '../../../core/themes/text_scheme.dart';
import '../../../core/widgets/budget_card.dart';
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
            BudgetCard(presupuesto: widget.budget),
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
  const BudgetDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
