import 'package:cashly/core/models/presupuestos.dart';
import 'package:cashly/core/widgets/header.dart';
import 'package:cashly/core/widgets/menu.dart';
import 'package:cashly/feautures/budget/presentation/add_budget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/themes/text_scheme.dart';
import '../../../core/widgets/custom_button.dart';
import 'budget_detail.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  // TODO: load data from backend
  final List<Presupuestos> presupuestos = [
    Presupuestos(
      presId: 1,
      usuarioId: 2,
      categoriaId: 0,
      categoriaNom: "Hogar",
      presNombre: "Gastos Casa",
      presMontoInicial: 3000,
      presMontoUlt: 1000,
      esActivo: true,
      fechaCreacion: DateTime(2025, 2, 12),
      fechaUltAct: DateTime.now(),
      inicioRecurrencia: DateTime(2025, 2, 12),
      finRecurrencia: DateTime(2025, 8, 14),
    ),
    Presupuestos(
      presId: 1,
      usuarioId: 2,
      categoriaId: 2,
      categoriaNom: "Comida",
      presNombre: "Gastos Comida",
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
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBudgetScreen()),
    );

    if (result == true) {
      setState(() {
        loadBudget();
      });
    }
  }

  void loadBudget() {}

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
            GeneralBudgetCard(amount: 5000),
            // listado de presupuestos
            ListaBudgetCards(lista: presupuestos),
            // boton para ir a la pantalla de agregar presupuesto
            Padding(
              padding: EdgeInsets.fromLTRB(11, 0, 11, 16),
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

class GeneralBudgetCard extends StatelessWidget {
  const GeneralBudgetCard({super.key, required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
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
                  Icon(
                    Icons.attach_money,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Total en Presupuestos",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
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
                  color: Theme.of(context).colorScheme.secondary,
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
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Subtexto
          Text(
            "Este mes",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

class BudgetCard extends StatelessWidget {
  final Presupuestos presupuesto;

  const BudgetCard({super.key, required this.presupuesto});

  void navigateTo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BudgetDetailScreen(budget: presupuesto),
      ),
    );
  }

  Widget _buildMontoResumen(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.secondary),
        ),
        SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final restante = presupuesto.presMontoInicial - presupuesto.presMontoUlt;
    final porcentajeGastado =
        presupuesto.presMontoUlt / presupuesto.presMontoInicial;
    final diasTotales =
        presupuesto.finRecurrencia
            ?.difference(presupuesto.inicioRecurrencia!)
            .inDays;
    final diasRestantes =
        presupuesto.finRecurrencia?.difference(DateTime.now()).inDays;
    final promedioDiario =
        presupuesto.presMontoUlt /
        ((DateTime.now().difference(presupuesto.inicioRecurrencia!).inDays) +
            1);

    final currency = NumberFormat.currency(symbol: "\$", decimalDigits: 0);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título y acciones
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        presupuesto.presNombre,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        presupuesto.categoriaNom ?? "Categoría",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => navigateTo(context),
                    child: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Monto resumen
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMontoResumen(
                context,
                Icons.attach_money,
                "Límite",
                currency.format(presupuesto.presMontoInicial),
              ),
              _buildMontoResumen(
                context,
                Icons.money_off,
                "Gastado",
                currency.format(presupuesto.presMontoUlt),
              ),
              _buildMontoResumen(
                context,
                Icons.wallet,
                "Restante",
                currency.format(restante),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Progreso del periodo",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              minHeight: 12,
              value: porcentajeGastado.clamp(0.0, 1.0),
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "\$${promedioDiario.toStringAsFixed(1)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "Promedio/día",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Container(height: 28, width: 1, color: Colors.grey.shade300),
              Column(
                children: [
                  Text(
                    diasRestantes.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "Días Restantes",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ListaBudgetCards extends StatelessWidget {
  final List<Presupuestos> lista;

  const ListaBudgetCards({super.key, required this.lista});

  @override
  Widget build(BuildContext context) {
    if (lista.isEmpty) {
      return const Center(child: Text("No hay presupuestos registrados."));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // permite usar dentro de scrolls
      itemCount: lista.length,
      itemBuilder: (context, index) {
        return BudgetCard(presupuesto: lista[index]);
      },
    );
  }
}
