// lib/features/category/presentation/new_category_screen.dart

import 'package:flutter/material.dart';
import 'package:cashly/core/widgets/header.dart';
import 'package:cashly/core/widgets/form_input.dart';
import 'package:cashly/core/widgets/custom_button.dart';
import 'package:cashly/core/utils/icon_from_string.dart';
import 'package:cashly/core/services/category_service.dart';
import 'package:cashly/core/models/categoria.dart';

class NewCategoryScreen extends StatefulWidget {
  const NewCategoryScreen({Key? key}) : super(key: key);

  @override
  State<NewCategoryScreen> createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  final TextEditingController _nameController = TextEditingController();
  String? _selectedIconRef;
  bool _isLoading = false;

  Future<void> _onCreateCategory() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El nombre es obligatorio')),
      );
      return;
    }
    if (_selectedIconRef == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona un ícono')),
      );
      return;
    }
    setState(() => _isLoading = true);
    try {
      final Categoria nueva = await CategoryService.createCategory(
        nombre: name,
        descripcion: null,
        iconRef: _selectedIconRef!,
      );
      Navigator.of(context).pop(nueva);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear categoría: \$e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subheader: back + title + description
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Nueva Categoría',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Crea una categoría personalizada para ingresos',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 24),

            // Nombre de la categoría
            FormInput(
              inputController: _nameController,
              title: 'Nombre de la Categoría',
              hintText: 'ej: colegio, comida, etc',
              maxLength: 20,
            ),
            const SizedBox(height: 24),

            // Selector de íconos
            Text(
              'Selecciona un Ícono',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 6,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: iconRefs.map((ref) {
                final selected = ref == _selectedIconRef;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIconRef = ref),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selected
                          ? Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1)
                          : Colors.transparent,
                      border: Border.all(
                        color: selected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade300,
                        width: selected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      getIconFromString(ref),
                      size: 28,
                      color: selected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.shade700,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Botón Crear Categoría
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: _isLoading ? 'Creando...' : 'Crear Categoría',
                onPressed: _isLoading ? null : _onCreateCategory,
                style: 'primary',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
