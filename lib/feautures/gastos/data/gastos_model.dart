import 'package:cashly/core/services/gastos_service.dart';
import 'package:flutter/material.dart';

final gastosService = GastosService();
void _subirGasto() async {
  try {
    final nuevoGasto = {
      "pres_id": 1,
      "categoria_id": 2,
      "periodo_id": 3,
      "gasto_nombre": "Uber",
      "gasto_monto": 150.0,
      "gasto_fecha": DateTime.now().toIso8601String(), // o "2025-07-15"
      "gasto_frecuencia": "único",
      "inicio_recurrencia": null,
      "fin_recurrencia": null,
    };

    final resultado = await gastosService.createGasto(nuevoGasto);
    print("Gasto creado: $resultado");

    // Opcional: mostrar snackbar o navegar atrás
  } catch (e) {
    print("Error: $e");
    // Puedes usar ScaffoldMessenger para mostrar error al usuario
  }
}
