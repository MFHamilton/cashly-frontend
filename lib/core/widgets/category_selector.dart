import 'package:flutter/material.dart';

/// Modelo que representa cada categoría
class CategoryItem {
  final IconData icon;
  final String label;
  CategoryItem({required this.icon, required this.label});
}

/// Widget que expone la selección de categorías en forma de grid
class CategorySelector extends StatefulWidget {
  /// Lista de categorías a mostrar
  final List<CategoryItem> items;

  /// Callback que recibe la categoría seleccionada
  final ValueChanged<CategoryItem> onChanged;

  /// (Opcional) Índice inicial seleccionado
  final int initialSelected;

  const CategorySelector({
    Key? key,
    required this.items,
    required this.onChanged,
    this.initialSelected = -1,
  }) : super(key: key);

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,                        // para meterlo en Column/ListView
      physics: NeverScrollableScrollPhysics(), // que no scrollee internamente
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final selected = index == _selectedIndex;
        return _CategoryCard(
          item: item,
          selected: selected,
          onTap: () {
            setState(() => _selectedIndex = index);
            widget.onChanged(item);
          },
        );
      },
    );
  }
}

/// Una card individual con icono, texto y estado seleccionado
class _CategoryCard extends StatelessWidget {
  final CategoryItem item;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryCard({
    Key? key,
    required this.item,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? primary.withOpacity(0.15) : Colors.grey[100],
          border: Border.all(
            color: selected ? primary : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon,
                size: 32, color: selected ? primary : Colors.grey[700]),
            SizedBox(height: 8),
            Text(item.label,
                style: TextStyle(
                  fontSize: 16,
                  color: selected ? primary : Colors.grey[800],
                )),
          ],
        ),
      ),
    );
  }
}
