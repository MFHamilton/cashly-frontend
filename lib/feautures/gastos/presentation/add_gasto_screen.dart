import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/models/categoria.dart';
import '../../../core/services/category_service.dart';
import '../../../core/services/gastos_service.dart';
import '../../../core/themes/text_scheme.dart';
import '../../../core/utils/icon_from_string.dart';
import '../../../core/widgets/category.dart' as CategoryInput;
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/duration.dart' as Duration;
import '../../../core/widgets/form_input.dart';
import '../../../core/widgets/frecuency.dart' as FrecuencyWidget;
import '../../../core/widgets/header.dart';
import '../../../core/widgets/menu.dart';

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

  final ValueNotifier<Categoria?> selectedCategoria = ValueNotifier(null);
  late Future<List<Categoria>> categoryListFuture;
  int? selectedFrecuencyIndex;

  final List<String> frecuenciaOpciones = [
    'Semanal',
    'Quincenal',
    'Mensual',
    'Trimestral',
    'Semestral',
    'Anual'
  ];

  @override
  void initState() {
    super.initState();
    categoryListFuture = CategoryService.fetchCategories();
  }

  String? _parseDate(String input) {
    try {
      // intenta ISO primero
      final dt = DateTime.parse(input);
      return dt.toIso8601String();
    } catch (_) {
      // si falla, prueba con dd/MM/yyyy
      final parts = input.split('/');
      if (parts.length == 3) {
        final day   = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year  = int.parse(parts[2]);
        return DateTime(year, month, day).toIso8601String();
      }
    }
    return null;
  }

  void _onRegistrar() async {
    if (!_formKey.currentState!.validate()) return;

    final nombre = _nombreController.text.trim();
    final montoText = _montoController.text.replaceAll(',', '');
    final monto = double.tryParse(montoText);
    final categoriaSeleccionada = selectedCategoria.value;

    if (categoriaSeleccionada == null) {
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

    try {
      final gastoData = {
        "gasto_nombre": nombre,
        "gasto_monto": monto,
        "categoria_id": categoriaSeleccionada.categoriaId,
        "periodo_id": selectedFrecuencyIndex! + 1,
        "gasto_fecha": _startDateController.text.isNotEmpty
            ? _parseDate(_startDateController.text)
            : null,
        "inicio_recurrencia": _startDateController.text.isNotEmpty
            ? _parseDate(_startDateController.text)
            : null,
        "fin_recurrencia": _endDateController.text.isNotEmpty
            ? _parseDate(_endDateController.text)
            : null,
      };

      final service = GastosService();
      await service.createGasto(gastoData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gasto creado correctamente')),
      );

      Navigator.pop(context);
    } catch (e, stackTrace) {
      print("Error al guardar gasto: $e");
      print("Stack trace: $stackTrace");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const MenuLateralScreen(),
      appBar: Header(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
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
                        'Agregar Gasto',
                        style: Theme.of(context).textTheme.titleLarge
                      ),
                      Text(
                        'Registra una nueva fuente de gasto',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.7),

                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FormInput(
              inputController: _nombreController,
              title: 'Nombre del Gasto',
              hintText: 'ej: alquiler mensual',
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
            const SizedBox(height: 10),
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
            const SizedBox(height: 8),
            FrecuencyWidget.Frecuency(
              onSelect: (index) {
                setState(() {
                  selectedFrecuencyIndex = index;
                });
              },
              selectedIndex: selectedFrecuencyIndex,
            ),
            const SizedBox(height: 10),
            Container(
              child: Duration.Duration(
                dateStartController: _startDateController,
                dateEndController: _endDateController,
              ),
            ),
            const SizedBox(height: 15),
            CustomButton(
              text: 'Guardar Gasto',
              onPressed: _onRegistrar,
              style: 'primary',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}


