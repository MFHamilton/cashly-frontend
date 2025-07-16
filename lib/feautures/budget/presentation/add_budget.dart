import 'package:flutter/material.dart';
import 'package:cashly/core/constants/app_color.dart';
import 'package:cashly/core/models/categoria.dart';
import 'package:cashly/core/services/category_service.dart';
import 'package:cashly/core/services/budget_service.dart';
import 'package:cashly/core/widgets/category.dart' as CategoryInput;
import 'package:cashly/core/widgets/custom_button.dart';
import 'package:cashly/core/widgets/duration.dart' as Duration;
import 'package:cashly/core/widgets/form_input.dart';
import 'package:cashly/core/widgets/frecuency.dart';
import 'package:cashly/core/widgets/header.dart';
import 'package:cashly/core/widgets/menu.dart';

import 'package:cashly/core/widgets/notifications.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _montoCtrl = TextEditingController();
  final _startCtrl = TextEditingController();
  final _endCtrl = TextEditingController();

  late Future<List<Categoria>> _categoriesFuture;
  final selectedCategoria = ValueNotifier<Categoria?>(null);
  int? selectedFrecuencyIndex;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryService.fetchCategories();
  }

  String? _parseDate(String input) {
    final parts = input.split('/');
    if (parts.length == 3) {
      final d = int.parse(parts[0]), m = int.parse(parts[1]), y = int.parse(parts[2]);
      return DateTime(y, m, d).toIso8601String();
    }
    return null;
  }

  Future<void> _onGuardar() async {
    if (!_formKey.currentState!.validate()) return;
    final cat = selectedCategoria.value;
    if (cat == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecciona una categoría')));
      return;
    }
    if (selectedFrecuencyIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecciona una frecuencia')));
      return;
    }

    final data = {
      'pres_nombre': _nombreCtrl.text.trim(),
      'pres_monto_inicial': double.tryParse(_montoCtrl.text.replaceAll(',', '')) ?? 0,
      'pres_monto_ult': 0,
      'categoria_id': cat.categoriaId,
      'periodo_id': selectedFrecuencyIndex! + 1,
      'es_activo': true,
      'inicio_recurrencia': _startCtrl.text.isNotEmpty ? _parseDate(_startCtrl.text) : null,
      'fin_recurrencia': _endCtrl.text.isNotEmpty ? _parseDate(_endCtrl.text) : null,
    };

    try {
      await PresupuestoService().createPresupuesto(data);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Presupuesto creado')));
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
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

            // Titulo de la pantalla
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),

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
                        "Agregar presupuesto",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),

                      Text(
                        'Registra un nuevo presupuesto',
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
              inputController: _nombreCtrl,
              title: 'Nombre',
              hintText: 'ej: gastos del hogar',
              icon: Icons.text_snippet,
              validator: (v) => (v?.isEmpty ?? true) ? 'Requerido' : null,
            ),

            // Monto
            FormInput(
              inputController: _montoCtrl,
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

            // Categorías
            FutureBuilder<List<Categoria>>(
              future: _categoriesFuture,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snap.hasError) {
                  return Text('Error: ${snap.error}');
                } else {
                  return CategoryInput.Category(
                    categorias: snap.data!,
                    selectedCategoriaNotifier: selectedCategoria,
                  );
                }
              },
            ),

            const SizedBox(height: 24),

            // Frecuencia
            Frecuency(
              onSelect: (i) => setState(() => selectedFrecuencyIndex = i),
              selectedIndex: selectedFrecuencyIndex,
            ),

            Duration.Duration(
             dateStartController: _startCtrl,
                dateEndController: _endCtrl,
            ),

            Notifications(

            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: CustomButton(
                text: "Guardar Presupuesto",
                style: 'primary',
                //onPressed: _navigateAddBudget,

              ),
            ),

            const SizedBox(height: 24),

            // Guardar
            CustomButton(
              text: 'Guardar Presupuesto',
              style: 'primary',
              onPressed: _onGuardar,
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

