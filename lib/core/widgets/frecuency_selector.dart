import 'package:flutter/material.dart';


/// Las seis opciones fijas de frecuencia
enum FrequencyOption { semanal, quincenal, mensual, trimestral, semestral, anual }

extension FrequencyOptionExt on FrequencyOption {
  String get title {
    switch (this) {
      case FrequencyOption.semanal:    return 'Semanal';
      case FrequencyOption.quincenal:  return 'Quincenal';
      case FrequencyOption.mensual:    return 'Mensual';
      case FrequencyOption.trimestral: return 'Trimestral';
      case FrequencyOption.semestral:  return 'Semestral';
      case FrequencyOption.anual:      return 'Anual';
    }
  }
  String get subtitle {
    switch (this) {
      case FrequencyOption.semanal:    return 'Cada 7 días';
      case FrequencyOption.quincenal:  return 'Cada 15 días';
      case FrequencyOption.mensual:    return 'Cada mes';
      case FrequencyOption.trimestral: return 'Cada 3 meses';
      case FrequencyOption.semestral:  return 'Cada 6 meses';
      case FrequencyOption.anual:      return 'Cada año';
    }
  }
}

/// Widget principal
class FrequencySelector extends StatefulWidget {
  /// Opción inicial (por defecto Semanal)
  final FrequencyOption initialValue;

  /// Callback que recibe la opción seleccionada
  final ValueChanged<FrequencyOption> onChanged;

  const FrequencySelector({
    Key? key,
    this.initialValue = FrequencyOption.semanal,
    required this.onChanged,
  }) : super(key: key);

  @override
  _FrequencySelectorState createState() => _FrequencySelectorState();
}

class _FrequencySelectorState extends State<FrequencySelector> {
  late FrequencyOption _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Frecuencia', style: tt.headlineSmall),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 2.88,
          children: FrequencyOption.values.map(_buildOption).toList(),
        ),
      ],
    );
  }

  Widget _buildOption(FrequencyOption option) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final bool isSel = option == _selected;

    return GestureDetector(
      onTap: () {
        setState(() => _selected = option);
        widget.onChanged(option);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSel ? cs.primaryContainer : cs.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSel ? cs.primary : cs.onSurface.withOpacity(0.12),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              option.title,
              style: tt.titleMedium?.copyWith(
                color: isSel ? cs.primary : cs.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(option.subtitle, style: tt.bodySmall),
          ],
        ),
      ),
    );
  }
}
