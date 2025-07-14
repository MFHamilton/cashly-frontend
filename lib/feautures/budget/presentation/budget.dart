import 'package:cashly/core/models/presupuestos.dart';
import 'package:cashly/core/widgets/header.dart';
import 'package:cashly/core/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/themes/text_scheme.dart';
import '../../../core/widgets/custom_button.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final List<Presupuestos> presupuestos = [
    Presupuestos(
      presId: 1,
      usuarioId: 2,
      presNombre: "Gastos Casa",
      presMontoInicial: 2000,
      presMontoUlt: 550,
      esActivo: true,
      fechaCreacion: DateTime(2025, 2, 12),
      fechaUltAct: DateTime.now(),
      inicioRecurrencia: DateTime(2025, 2, 12),
      finRecurrencia: DateTime(2025, 8, 14),
    ),
    Presupuestos(
      presId: 2,
      usuarioId: 2,
      presNombre: "Auto",
      presMontoInicial: 2000,
      presMontoUlt: 550,
      esActivo: true,
      fechaCreacion: DateTime(2025, 2, 12),
      fechaUltAct: DateTime.now(),
      inicioRecurrencia: DateTime(2025, 2, 12),
      finRecurrencia: DateTime(2025, 8, 14),
    ),
    Presupuestos(
      presId: 3,
      usuarioId: 2,
      presNombre: "Gym y salud",
      presMontoInicial: 2000,
      presMontoUlt: 550,
      esActivo: true,
      fechaCreacion: DateTime(2025, 2, 12),
      fechaUltAct: DateTime.now(),
      inicioRecurrencia: DateTime(2025, 2, 12),
      finRecurrencia: DateTime(2025, 8, 14),
    ),
  ];

  Future<void> navigateAddBudget() async {
    /*final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddGoalScreen()),
    );

    if (result == true) {
      setState(() {
        loadBudget();
      });
    }*/
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
            // Card con el presupesto total del mes
            BudgetCard(amount: 5000),
            // TODO: listado de presupuestos
            // boton para ir a la pantalla de agregar presupuesto
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
              child: CustomButton(
                text: "+ Agregar Presupuesto",
                style: 'primary',
                onPressed: navigateAddBudget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BudgetCard extends StatelessWidget {
  const BudgetCard({super.key, required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Línea superior
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.attach_money, color: Colors.green, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    "Total en Presupuestos",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Julio 2025",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Monto
          Text(
            "RD\$${NumberFormat("#,##0.00", "en_US").format(amount)}",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.green.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Subtexto
          Text(
            "Este mes",
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.green.shade800),
          ),
        ],
      ),
    );
  }
}
