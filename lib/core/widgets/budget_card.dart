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
        const SizedBox(height: 4),
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
    // — PARSEO SEGURO DE MONTOS —
    final double montoInicial = double.tryParse(
        presupuesto.presMontoInicial.toString()) ??
        0.0;
    final double montoGastado =
        double.tryParse(presupuesto.presMontoUlt.toString()) ?? 0.0;
    final double restante = montoInicial - montoGastado;
    final double porcentajeGastado = montoInicial > 0
        ? (montoGastado / montoInicial).clamp(0.0, 1.0)
        : 0.0;

    // — FECHAS NULL-SAFE —
    final DateTime? inicio = presupuesto.inicioRecurrencia;
    final DateTime? fin = presupuesto.finRecurrencia;

    final int? diasTotales = (inicio != null && fin != null)
        ? fin.difference(inicio).inDays
        : null;
    final int? diasRestantes =
    fin != null ? fin.difference(DateTime.now()).inDays : null;

    final double? promedioDiario = (inicio != null)
        ? montoGastado /
        (DateTime.now().difference(inicio).inDays + 1)
        : null;

    final currency =
    NumberFormat.currency(symbol: "\$", decimalDigits: 0);

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
          // TÍTULO Y ACCIONES (igual)
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
                        style: const TextStyle(color: Colors.grey),
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
                  const SizedBox(width: 8),
                  Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // MONTO RESUMEN (igual)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMontoResumen(
                context,
                Icons.attach_money,
                "Límite",
                currency.format(montoInicial),
              ),
              _buildMontoResumen(
                context,
                Icons.money_off,
                "Gastado",
                currency.format(montoGastado),
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

          // BARRA DE PROGRESO (igual)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              minHeight: 12,
              value: porcentajeGastado,
              backgroundColor: Colors.grey.shade300,
              valueColor:
              const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),

          const SizedBox(height: 16),

          // PROMEDIO/DÍA Y DÍAS RESTANTES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Promedio/día
              Column(
                children: [
                  Text(
                    "\$${promedioDiario != null ? promedioDiario.toStringAsFixed(1) : '–'}",
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

              // Días Restantes
              Column(
                children: [
                  Text(
                    diasRestantes != null ? diasRestantes.toString() : '–',
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
