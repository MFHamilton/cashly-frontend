import 'package:cashly/core/constants/app_color.dart';
import 'package:cashly/core/themes/text_scheme.dart';
import 'package:cashly/core/widgets/custom_button.dart';
import 'package:cashly/core/widgets/form_input.dart';
import 'package:cashly/core/widgets/header.dart';
import 'package:cashly/core/widgets/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddGoalScreen extends StatelessWidget {
  AddGoalScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(width: 4),
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
              inputController: nameController,
              title: "Nombre de la meta",
              hintText: "ej: fondo de emergencias",
              icon: Icons.label,
            ),
            FormInput(
              inputController: nameController,
              title: "Nombre de la meta",
              hintText: "ej: fondo de emergencias",
              icon: Icons.label,
            ),
            // TODO: seleccionar categoria
            // GoalInput(controller: controller, label: label, count: count, defaultText: defaultText),
            // TODO: fechas
            // boton para enviar la solicitud
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: CustomButton(
                text: "Guardar Meta",
                onPressed: () {
                  // TODO: enviar la solicitud y redirigir a la pantalla de metas
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
