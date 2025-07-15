import 'package:flutter/material.dart';

import '../../../core/models/categoria.dart';
import '../../../core/services/category_service.dart';
import '../../../core/services/goal_service.dart';
import '../../../core/themes/text_scheme.dart';
import '../../../core/widgets/category.dart' as CategoryInput;
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/duration.dart' as Duration;
import '../../../core/widgets/form_input.dart';
import '../../../core/widgets/header.dart';
import '../../../core/widgets/menu.dart';
import '../../../feautures/goals/data/models/goal.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  late Future<List<Categoria>> categoryListFuture;
  late List<Categoria> categoryList;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  final ValueNotifier<Categoria?> selectedCategoria = ValueNotifier(null);

  void addGoal() async {
    final categoriaSeleccionada = selectedCategoria.value;

    if (categoriaSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona una categoría")),
      );
      return;
    }

    GoalModel goal = GoalModel(
      metaId: 0,
      usuarioId: 0, // Asegúrate de reemplazarlo con el ID real del usuario
      periodoId: 1,
      metaNombre: nameController.text.trim(),
      metaDescripcion: descriptionController.text.trim(),
      metaMontoInicial: double.tryParse(amountController.text.replaceAll(',', '')) ?? 0,
      metaMontoUlt: 0,
      categoriaId: categoriaSeleccionada.categoriaId,
      categoriaNom: null,
      fechaInicio: DateTime.parse(startDateController.text),
      fechaFin: endDateController.text.isNotEmpty
          ? DateTime.parse(endDateController.text)
          : null,
      metaEsActivo: true,
    );

    try {
      await GoalService.postGoal(goal);
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
            Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios),
                  const SizedBox(width: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Agregar Meta",
                        style: MyTextTheme.lightTextTheme.headlineMedium,
                      ),
                      Text(
                        "Registra una nueva meta",
                        style: MyTextTheme.lightTextTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FormInput(
              inputController: nameController,
              title: "Nombre de la meta",
              hintText: "ej: fondo de emergencias",
              icon: Icons.label,
            ),
            FormInput(
              inputController: amountController,
              title: "Monto",
              hintText: "\$0.00",
              icon: Icons.attach_money,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            FormInput(
              inputController: descriptionController,
              title: "Descripción",
              hintText: "describe tu meta...",
              icon: null,
            ),
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
                  return const Text("Sin categorías disponibles");
                }
              },
            ),
            Duration.Duration(
              dateStartController: startDateController,
              dateEndController: endDateController,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: CustomButton(
                text: "Guardar Meta",
                style: 'primary',
                onPressed: addGoal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
