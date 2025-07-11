import 'package:cashly/core/constants/app_color.dart';
import 'package:cashly/core/themes/text_scheme.dart';
import 'package:cashly/core/widgets/category_selector.dart';
import 'package:cashly/core/widgets/custom_button.dart';
import 'package:cashly/core/widgets/form_input.dart';
import 'package:cashly/core/widgets/header.dart';
import 'package:cashly/core/widgets/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  List<CategoryItem> categoryItems = [
    CategoryItem(icon: Icons.health_and_safety, label: 'Salud'),
    CategoryItem(icon: Icons.flight, label: 'Viajes'),
    CategoryItem(icon: Icons.school, label: 'Educación'),
    CategoryItem(icon: Icons.savings, label: 'Ahorro'),
    CategoryItem(icon: Icons.home, label: 'Hogar'),
    CategoryItem(icon: Icons.directions_car, label: 'Transporte'),
  ];

  CategoryItem? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
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
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
              child: Text(
                "Categoría",
                style: MyTextTheme.lightTextTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: CategorySelector(
                  items: categoryItems,
                  onChanged: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
            ),
            // fechas
            FormInput(
              inputController: startDateController,
              title: "Fecha de inicio",
              hintText: "Seleccionar Fecha",
              icon: Icons.date_range,
            ),
            FormInput(
              inputController: endDateController,
              title: "Fecha de fin (opcional)",
              hintText: "Seleccionar Fecha",
              icon: Icons.date_range,
            ),
            // botón para enviar la solicitud
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

class DateRangePicker extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final String title;
  final IconData? icon;
  final TextInputType? keyboardType;
  final String? prefixText;
  final FormFieldValidator<String>? validator;
  final int? maxLength;


  const DateRangePicker({
    super.key,
    required this.inputController,
    this.hintText = '',
    this.title = '',
    this.icon,
    this.keyboardType,
    this.prefixText,
    this.validator,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Row(
              children: [
                if (icon != null)
                  Icon(icon, color: Theme.of(context).colorScheme.primary),
                if (icon != null)
                  SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          SizedBox(height: 8),
          TextFormField(
            controller: inputController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              hintText: hintText,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary, // o cualquier otro color
                  //width: 1.5, // ancho opcional
                ),
              ),

            ),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
