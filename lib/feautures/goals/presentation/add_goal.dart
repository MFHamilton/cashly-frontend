import 'package:flutter/material.dart';

import '../../../core/models/categoria.dart';
import '../../../core/models/icon_helper.dart';
import '../../../core/services/category_service.dart';
import '../../../core/services/goal_service.dart';
import '../../../core/themes/text_scheme.dart';
import '../../../core/widgets/category.dart' as CategoryInput;
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/duration.dart' as Duration;
import '../../../core/widgets/form_input.dart';
import '../../../core/widgets/header.dart';
import '../../../core/widgets/menu.dart';
import '../../../core/utils/icon_from_string.dart';
import '../../../feautures/goals/data/models/goal.dart';

iconFromString(String iconRef) {}


class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});
  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  late Future<List<Categoria>> categoryListFuture;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  final ValueNotifier<int?> selectedCategoryIndex = ValueNotifier<int?>(null);

  void addGoal() async {
    final index = selectedCategoryIndex.value;
    final categoriaId = index != null ? index + 1 : null;

    GoalModel goal = GoalModel(
      metaId: 0,
      usuarioId: 0,
      periodoId: 1,
      metaNombre: nameController.text,
      metaDescripcion: descriptionController.text,
      metaMontoInicial: double.parse(amountController.text),
      metaMontoUlt: 0,
      categoriaId: categoriaId,
      categoriaNom: null,
      fechaInicio: DateTime.parse(startDateController.text),
      fechaFin:
          endDateController.text != ""
              ? DateTime.parse(endDateController.text)
              : null,
      metaEsActivo: true,
    );

    try {
      await GoalService.postGoal(goal);

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
      drawer: const MenuLateralScreen(),
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(width: 2),
                  Column(
                    children: [
                      Text(
                        "Agregar Meta",
                        style: MyTextTheme.lightTextTheme.bodyLarge,
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
            ),
            FormInput(
              inputController: descriptionController,
              title: "Descripción",
              hintText: "describe tu meta...",
              icon: null,
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
                    data.map((c) => getIconFromString(c.iconRef)).toList(),
                    selectedIndexNotifier: selectedCategoryIndex,
                  );
                } else {
                  return Text("Sin datos");
                }
              },
            ),
            // fechas
            Duration.Duration(
              dateStartController: startDateController,
              dateEndController: endDateController,
            ),
            // botón para enviar la solicitud
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
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
