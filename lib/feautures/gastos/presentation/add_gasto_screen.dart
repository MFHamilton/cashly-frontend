import 'package:cashly/core/widgets/category.dart';
import 'package:cashly/core/widgets/frecuency.dart';
import 'package:cashly/core/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/widgets/form_input.dart';
import '../../../core/widgets/frecuency_selector.dart';
import '../../../core/widgets/header.dart';
import '../../../core/themes/text_scheme.dart';

class AgregarGastoScreen extends StatefulWidget {
  const AgregarGastoScreen({Key? key}) : super(key: key);

  @override
  _AgregarGastoScreenState createState() => _AgregarGastoScreenState();
}

class _AgregarGastoScreenState extends State<AgregarGastoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  final ValueNotifier<int?> selectedCategoryIndex = ValueNotifier<int?>(null);


  void _onRegistrar() {

  }

  Future<void> _pickDate(TextEditingController controller) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = '${picked.day.toString().padLeft(2,'0')}/${picked.month.toString().padLeft(2,'0')}/${picked.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const MenuLateralScreen(),
      appBar: Header(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            // Encabezado manual con flecha de regreso
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Agregar Gasto',
                        style: MyTextTheme.lightTextTheme.headlineMedium,
                      ),
                      Text(
                        'Registra una nueva fuente de gasto',
                        style: MyTextTheme.lightTextTheme.labelLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Campos de formulario
            FormInput(
              inputController: _nombreController,
              title: 'Nombre del Gasto',
              hintText: 'ej: salario mensual',
              icon: Icons.label,
              maxLength: 20,
              validator: (v) => (v?.isEmpty ?? true) ? 'Requerido' : null,
            ),
            FormInput(
              inputController: _montoController,
              title: 'Monto',
              hintText: '\$ 0.00',
              icon: Icons.attach_money,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              prefixText: '\$ ',
              validator: (v) {
                final n = double.tryParse(v?.replaceAll(',', '') ?? '');
                return (n == null) ? 'Monto inválido' : null;
              },
            ),
            const SizedBox(height: 24),
            // Selector de categoría
            Category(
                title: [
                  'Vivienda',
                  'Comida',
                  'Transporte',
                  'Salud',
                  'Compras',
                  'Electricidad',
                  'Otros',
                  'Nueva Categoria'
                  ], icon: [
                    Icons.house,
                    Icons.fastfood,
                    Icons.directions_bus,
                    Icons.health_and_safety,
                    Icons.shopping_cart,
                    Icons.bolt,
                    Icons.more_horiz,
                    Icons.add
                            ],
                selectedIndexNotifier: selectedCategoryIndex
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 24),
            // Frecuencia
            Frecuency(),
            const SizedBox(height: 24),
            // Sección Duración del Gasto al final
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Duración del Gasto',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FormInput(
                    inputController: _startDateController,
                    title: 'Fecha de Inicio',
                    hintText: 'Seleccionar Fecha',
                    icon: Icons.date_range,
                    onTap: () => _pickDate(_startDateController),
                  ),
                  const SizedBox(height: 12),
                  FormInput(
                    inputController: _endDateController,
                    title: 'Fecha de Fin (Opcional)',
                    hintText: 'Seleccionar Fecha',
                    icon: Icons.date_range,
                    onTap: () => _pickDate(_endDateController),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Registrar',
              onPressed: _onRegistrar,
              style: 'primary',
            ),
            SizedBox(height: 24),

          ],
        ),
      ),

    );
  }
}


