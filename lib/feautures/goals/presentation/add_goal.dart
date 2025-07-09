import 'package:cashly/core/constants/app_color.dart';
import 'package:cashly/core/themes/text_scheme.dart';
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

            GoalInput(
              controller: nameController,
              label: "Nombre de la meta",
              count: true,
              defaultText: "ej: fondo de emergencias",
            ),
          ],
        ),
      ),
    );
  }
}

class GoalInput extends StatefulWidget {
  const GoalInput({
    super.key,
    required this.controller,
    required this.label,
    required this.count,
    required this.defaultText,
  });

  final TextEditingController controller;
  final String label;
  final bool count;
  final String defaultText;

  @override
  State<GoalInput> createState() => _GoalInputState();
}

class _GoalInputState extends State<GoalInput> {
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.count) {
      widget.controller.addListener(() {
        setState(() {
          _charCount = widget.controller.text.length;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textPrimary, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.label,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                'Nombre de la Meta',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: widget.controller,
            maxLength: 20,
            decoration: InputDecoration(
              hintText: 'ej: fondo de emergencia',
              counterText: '$_charCount/20 caracteres',
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(
                  color:
                      Colors
                          .grey
                          .shade300, // o cualquier color que coincida con tu diseño
                  width: 1,
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
