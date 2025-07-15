import 'package:flutter/material.dart';

class Frecuency extends StatelessWidget {
  final int? selectedIndex;
  final Function(int) onSelect;

  const Frecuency({
    super.key,
    this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      'Semanal',
      'Quincenal',
      'Mensual',
      'Trimestral',
      'Semestral',
      'Anual'
    ];
    final List<String> optionDates = [
      'Cada 7 días',
      'Cada 15 días',
      'Cada mes',
      'Cada 3 meses',
      'Cada 6 meses',
      'Cada año'
    ];

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer, // 🔴 Color de fondo
        borderRadius: BorderRadius.circular(3),
        boxShadow: const [
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
          Text(
            'Frecuencia',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 150 / 80,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(6, (index) {
              final selected = index == selectedIndex;

              return GestureDetector(
                onTap: () => onSelect(index),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: selected
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.primaryContainer,
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
                      Text(
                        options[index],
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                      ),
                      Text(
                        optionDates[index],
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}


