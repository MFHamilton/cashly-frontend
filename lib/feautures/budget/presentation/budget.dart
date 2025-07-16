import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../core/models/presupuestos.dart';
import '../../../core/themes/text_scheme.dart';
import '../../../core/widgets/budget_card.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/general_budget_card.dart';
import '../../../core/widgets/header.dart';
import '../../../core/widgets/menu.dart';
import '../../../feautures/budget/presentation/add_budget.dart';
import '../../../core/services/firebase_api.dart';
import '../../home/presentation/home_screen.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});
  //static const route = '/budget';


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
    //final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      drawer: const MenuLateralScreen(),
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titulo de la pantalla
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF28523A)),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    ),
                  ),
                  const SizedBox(width: 8),

                  Text(
                    "Presupuesto",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),

            /*
            Text('${message.notification?.title}'),
            Text('${message.notification?.body}'),
            Text('${message.data}'),
            */


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
