// lib/features/category/presentation/category_widget.dart

import 'package:cashly/feautures/category/presentation/new_category.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/icon_from_string.dart';
import '../models/categoria.dart';

class Category extends StatefulWidget {
  final List<Categoria> categorias;
  final ValueNotifier<Categoria?> selectedCategoriaNotifier;

  const Category({
    super.key,
    required this.categorias,
    required this.selectedCategoriaNotifier,
  });

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    // +1 para la casilla de "Nueva Categoría"
    final itemCount = widget.categorias.length + 1;

    return Container(
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categorías',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Text(
            'Selecciona una categoría',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(itemCount, (index) {
              // Última casilla: Nueva Categoría
              if (index == widget.categorias.length) {
                return GestureDetector(
                  onTap: () async {
                    final nueva = await Navigator.push<Categoria?>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NewCategoryScreen(),
                      ),
                    );
                    if (nueva != null) {
                      setState(() {
                        widget.categorias.add(nueva);
                        _selectedIndex = widget.categorias.length - 1;
                        widget
                            .selectedCategoriaNotifier.value = nueva;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Nueva Categoría',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Casillas de categorías existentes
              final selected = index == _selectedIndex;
              final categoria = widget.categorias[index];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (_selectedIndex == index) {
                      _selectedIndex = null;
                      widget.selectedCategoriaNotifier.value = null;
                    } else {
                      _selectedIndex = index;
                      widget.selectedCategoriaNotifier.value = categoria;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selected
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: selected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                      width: 1.5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        getIconFromString(categoria.iconRef),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        categoria.categoriaNom,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}

