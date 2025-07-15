import 'package:cashly/core/services/budget_service.dart';
import 'package:flutter/material.dart';

import '../../../core/models/presupuestos.dart';
import '../../../core/themes/text_scheme.dart';
import '../../../core/widgets/budget_card.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/general_budget_card.dart';
import '../../../core/widgets/header.dart';
import '../../../core/widgets/menu.dart';
import '../../../feautures/budget/presentation/add_budget.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  late Future<List<Presupuestos>> budgetFuture;
  late Future<double> amountFuture;

  void loadBudget() {
    budgetFuture = BudgetService.fetchBudget();
    amountFuture = BudgetService.fetchBudgetAmount();
  }

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

  @override
  void initState() {
    super.initState();
    loadBudget();
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
            FutureBuilder<double>(
              future: amountFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return GeneralBudgetCard(amount: data);
                } else {
                  return Text("Sin datos");
                }
              },
            ),
            // listado de presupuestos
            FutureBuilder<List<Presupuestos>>(
              future: budgetFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return ListaBudgetCards(lista: data);
                } else {
                  return Text("Sin datos");
                }
              },
            ),
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
