import 'package:cashly/core/models/presupuestos.dart';
import 'package:cashly/core/services/category_service.dart';
import 'package:cashly/core/widgets/header.dart';
import 'package:cashly/core/widgets/menu.dart';
import 'package:cashly/core/widgets/notifications.dart';
import 'package:flutter/material.dart';

import '../../../core/models/categoria.dart';
import '../../../core/themes/text_scheme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/form_input.dart';
import '../../../core/widgets/category.dart' as CategoryInput;
import '../../../core/widgets/duration.dart' as Duration;
import '../../../core/widgets/frecuency.dart';
import '../../../core/services/budget_service.dart';

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

  int? selectedFrecuencyIndex;
  late Future<List<Categoria>> categoryListFuture;
  late List<Categoria> categoryList;

  final ValueNotifier<Categoria?> selectedCategoria = ValueNotifier(null);

  void addBudget() async {
    final categoriaSeleccionada = selectedCategoria.value;

    if (categoriaSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona una categoría")),
      );
      return;
    }

    if (selectedFrecuencyIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona una frecuencia")),
      );
      return;
    }

    Presupuestos budget = Presupuestos(
      presId: 0,
      usuarioId: 1, // ⚠️ Reemplazar por el ID real del usuario
      presNombre: nameController.text.trim(),
      presMontoInicial: double.tryParse(amountController.text.replaceAll(',', '')) ?? 0,
      presMontoUlt: 0,
      esActivo: true,
      fechaCreacion: DateTime.now(),
      fechaUltAct: DateTime.now(),
      inicioRecurrencia: DateTime.parse(startDateController.text),
      finRecurrencia: endDateController.text.isNotEmpty
          ? DateTime.parse(endDateController.text)
          : null,
      categoriaId: categoriaSeleccionada.categoriaId,
      categoriaNom: null,
      periodoId: selectedFrecuencyIndex! + 1,
    );

    try {
      await BudgetService.postBudget(budget);
      Navigator.pop(context, true);
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
      drawer: const MenuLateralScreen(),
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titulo de la pantalla
            Container(
              width: 180,
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios),
                  const SizedBox(width: 4),
                  Text(
                    "Agregar presupuesto",
                    style: Theme.of(context).textTheme.headlineMedium,
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
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            // Categorías desde backend
            FutureBuilder<List<Categoria>>(
              future: categoryListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  categoryList = snapshot.data!;
                  return CategoryInput.Category(
                    categorias: categoryList,
                    selectedCategoriaNotifier: selectedCategoria,
                  );
                } else {
                  return const Text("Sin datos");
                }
              },
            ),
            Frecuency(
              onSelect: (index) {
                setState(() {
                  selectedFrecuencyIndex = index;
                });
              },
              selectedIndex: selectedFrecuencyIndex,
            ),
            Duration.Duration(
              dateStartController: startDateController,
              dateEndController: endDateController,
            ),

            Notifications(

            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
