import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../feautures/budget/presentation/budget_detail.dart';
import '../models/presupuestos.dart';

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