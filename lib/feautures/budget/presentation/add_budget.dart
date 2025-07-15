import 'package:cashly/core/models/presupuestos.dart';
import 'package:cashly/core/services/category_service.dart';
import 'package:cashly/core/widgets/header.dart';
import 'package:cashly/core/widgets/menu.dart';
import 'package:cashly/core/widgets/notifications.dart';
import 'package:flutter/material.dart';

import '../../../core/models/categoria.dart';
import '../../../core/services/budget_service.dart';
import '../../../core/themes/text_scheme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/form_input.dart';
import '../../../core/widgets/category.dart' as CategoryInput;
import '../../../core/widgets/duration.dart' as Duration;
import '../../../core/models/icon_helper.dart';
import '../../../core/widgets/frecuency.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({super.key});

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  late Future<List<Categoria>> categoryListFuture;

  final ValueNotifier<int?> selectedCategoryIndex = ValueNotifier<int?>(null);

  void addBudget() async {
    final index = selectedCategoryIndex.value;
    final categoriaId = index != null ? index + 1 : null;

    Presupuestos budget = Presupuestos(
      presId: 0,
      usuarioId: 1,
      presNombre: nameController.text,
      presMontoInicial: double.parse(amountController.text),
      presMontoUlt: 0,
      esActivo: true,
      fechaCreacion: DateTime.now(),
      fechaUltAct: DateTime.now(),
      inicioRecurrencia: DateTime.parse(startDateController.text),
      finRecurrencia:
          endDateController.text != ""
              ? DateTime.parse(endDateController.text)
              : null,
      categoriaId: categoriaId,
      categoriaNom: null,
      periodoId: null,
    );

    try {
      await BudgetService.postBudget(budget);

      Navigator.pop(context, true);
      print("NO ERROR");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    categoryListFuture = CategoryService.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateralScreen(),
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titulo de la pantalla
            Container(
              width: 180,
              padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(width: 4),
                  Text(
                    "Agregar presupuesto",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            FormInput(
              inputController: nameController,
              title: "Nombre",
              hintText: "ej: gastos del hogar, vacaciones",
              icon: Icons.text_snippet,
            ),
            FormInput(
              inputController: amountController,
              title: "Monto",
              hintText: "\$0.00",
              icon: Icons.attach_money,
            ),
            // cargar categorias del backend
            FutureBuilder<List<Categoria>>(
              future: categoryListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return CategoryInput.Category(
                    title: data.map((c) => c.categoriaNom).toList(),
                    icon:
                        data.map((c) => IconHelper.getIcon(c.iconRef)).toList(),
                    selectedIndexNotifier: selectedCategoryIndex,
                  );
                } else {
                  return Text("Sin datos");
                }
              },
            ),
            Frecuency(), // TODO: confirmar si esto va en este formulario
            // fechas
            Duration.Duration(
              dateStartController: startDateController,
              dateEndController: endDateController,
            ),
            // alertas
            Notifications(),
            // guardar presupuesto
            Padding(
              padding: EdgeInsets.fromLTRB(12, 16, 12, 8),
              child: CustomButton(
                text: "Guardar Presupuesto",
                style: 'primary',
                onPressed: addBudget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
