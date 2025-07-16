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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.event_repeat, color: Theme.of(context).colorScheme.primary,),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Frecuencia',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    '¿Con qué frecuencia se repite?',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.7)
                    ),
                  ),
                ],
              ),
            ],
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
                  margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: selected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.primaryContainer,
                      width: 1.5,
                    ),

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
                            .labelSmall
                            ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5)),
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


