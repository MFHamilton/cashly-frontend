import 'package:flutter/material.dart';
import '../../../core/services/ingresos_service.dart';
import 'package:cashly/core/constants/app_color.dart';
import 'package:cashly/core/models/categoria.dart';
import 'package:cashly/core/services/category_service.dart';
import 'package:cashly/core/themes/text_scheme.dart';
import 'package:cashly/core/widgets/category.dart' as CategoryInput;
import 'package:cashly/core/widgets/custom_button.dart';
import 'package:cashly/core/widgets/duration.dart' as Duration;
import 'package:cashly/core/widgets/form_input.dart';
import 'package:cashly/core/widgets/frecuency.dart' as FrecuencyWidget;
import 'package:cashly/core/widgets/header.dart';
import 'package:cashly/core/widgets/menu.dart';

class AddIngresoScreen extends StatefulWidget {
  const AddIngresoScreen({Key? key}) : super(key: key);

  @override
  _AddIngresoScreenState createState() => _AddIngresoScreenState();
}

class _AddIngresoScreenState extends State<AddIngresoScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  final ValueNotifier<Categoria?> selectedCategoria = ValueNotifier(null);
  late Future<List<Categoria>> categoryListFuture;
  int? selectedFrecuencyIndex;

  @override
  void initState() {
    super.initState();
    categoryListFuture = CategoryService.fetchCategories();
  }

  String? _parseDate(String input) {
    final parts = input.split('/');
    if (parts.length == 3) {
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime(year, month, day).toIso8601String();
    }
    return null;
  }

  void _onGuardar() async {
    if (!_formKey.currentState!.validate()) return;

    final nombre = _nombreController.text.trim();
    final montoText = _montoController.text.replaceAll(',', '');
    final monto = double.tryParse(montoText);
    final categoria = selectedCategoria.value;

    if (categoria == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona una categoría')),
      );
      return;
    }

    if (selectedFrecuencyIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona una frecuencia')),
      );
      return;
    }

    final ingresoData = {
      'ingreso_nombre': nombre,
      'ingreso_monto': monto,
      'categoria_id': categoria.categoriaId,
      'periodo_id': selectedFrecuencyIndex! + 1,
      'ingreso_fecha': DateTime.now().toIso8601String(),
      'inicio_recurrencia': _startDateController.text.isNotEmpty
          ? _parseDate(_startDateController.text)
          : null,
      'fin_recurrencia': _endDateController.text.isNotEmpty
          ? _parseDate(_endDateController.text)
          : null,
    };

    try {
      await IngresoService().createIngreso(ingresoData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingreso creado correctamente')),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar ingreso: $e')),
      );
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
            // Encabezado
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Agregar Ingreso',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Registra una nueva fuente de ingreso',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),

                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Nombre
            FormInput(
              inputController: _nombreController,
              title: 'Nombre del Ingreso',
              hintText: 'ej: salario mensual',
              icon: Icons.label,
              maxLength: 30,
              validator: (v) => (v?.isEmpty ?? true) ? 'Requerido' : null,
            ),

            // Monto
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

            const SizedBox(height: 10),

            // Categoría
            FutureBuilder<List<Categoria>>(
              future: categoryListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  return CategoryInput.Category(
                    categorias: snapshot.data!,
                    selectedCategoriaNotifier: selectedCategoria,
                  );
                } else {
                  return const Text("Sin categorías disponibles");
                }
              },
            ),

            const SizedBox(height: 10),

            // Frecuencia
            FrecuencyWidget.Frecuency(
              onSelect: (index) {
                setState(() {
                  selectedFrecuencyIndex = index;
                });
              },
              selectedIndex: selectedFrecuencyIndex,
            ),

            const SizedBox(height: 10),

            // Duración
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Duration.Duration(
                dateStartController: _startDateController,
                dateEndController: _endDateController,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              // Botón Guardar
              child: CustomButton(
                text: 'Guardar Ingreso',
                onPressed: _onGuardar,
                style: 'primary',
              ),

            ),



            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
