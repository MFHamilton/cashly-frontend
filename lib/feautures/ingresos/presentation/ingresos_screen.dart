import 'package:cashly/core/constants/app_color.dart';
import 'package:cashly/core/services/category_service.dart';
import 'package:cashly/core/services/ingresos_service.dart';
import 'package:cashly/core/widgets/delete_message.dart';
import 'package:cashly/core/widgets/header.dart';
import 'package:cashly/core/widgets/menu.dart';
import 'package:cashly/feautures/ingresos/presentation/add_ingreso_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/cardItem.dart';
import 'package:cashly/core/models/categoria.dart';

class IngresosScreen extends StatefulWidget {
  const IngresosScreen({Key? key}) : super(key: key);

  @override
  State<IngresosScreen> createState() => _IngresosScreenState();
}

class _IngresosScreenState extends State<IngresosScreen> {
  final _service = IngresoService();
  bool _loading = true;
  List<dynamic> _ingresos = [];
  List<Categoria> _categorias = [];

  final Map<int, String> periodos = {
    1: 'Semanal',
    2: 'Quincenal',
    3: 'Mensual',
    4: 'Trimestral',
    5: 'Semestral',
    6: 'Anual',
  };

  late Future<List<Categoria>> categoryListFuture;

  final String mesAnio = toBeginningOfSentenceCase(
    DateFormat('MMMM yyyy', 'es_ES').format(DateTime.now()),
  )!;

  @override
  void initState() {
    super.initState();
    categoryListFuture = CategoryService.fetchCategories();
    _fetchIngresos();
  }

  Future<void> _fetchIngresos() async {
    setState(() => _loading = true);
    try {
      _categorias = await CategoryService.fetchCategories();
      final now = DateTime.now();
      _ingresos = await _service.getIngresos(
        month: now.month,
        year: now.year,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar los ingresos: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  double get totalMes => _ingresos.fold(0.0, (sum, i) {
    final raw = i['ingreso_monto'];
    final monto = raw is num
        ? raw.toDouble()
        : double.tryParse(raw.toString()) ?? 0.0;
    return sum + monto;
  });

  void _onAgregarIngreso() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AddIngresoScreen()),
    );
    _fetchIngresos();
  }

  void _onEditIngreso(String ingresoId) {
    // TODO: implementar edición
  }

  void _onDeleteIngreso(String ingresoId, String ingresoNombre) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => Dialog(
        child: DeleteMessage(
          controllerName: ingresoNombre,
          targetRoute: const IngresosScreen(),
        ),
      ),
    );

    if (confirmed == true) {
      try {
        await _service.deleteIngreso(int.parse(ingresoId));
        await _fetchIngresos();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "$ingresoNombre eliminado",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.surface),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al eliminar: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9F3),
      drawer: const MenuLateralScreen(),
      appBar: Header(),
      body: Column(
        children: [
          // AppBar manual
          Container(
            height: kToolbarHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF28523A)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 8),
                Text('Ingresos', style: Theme.of(context).textTheme.headlineMedium),
                const Spacer(),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/user.svg',
                    width: 24,
                    height: 24,
                    color: const Color(0xFF28523A),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Tarjeta de Ingresos Totales
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.attach_money, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Ingresos Totales',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          mesAnio,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'RD\$${totalMes.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Este mes',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Estadística pequeña
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _SmallStatCard(
                  label: 'Activos',
                  value: '${_ingresos.length}',
                  iconColor: const Color(0xFFB5D4B1),
                ),
              ],
            ),
          ),

          // Lista de ingresos recientes
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _ingresos.isEmpty
                  ? const Center(child: Text('No hay ingresos este mes'))
                  : ListView.builder(
                itemCount: _ingresos.length,
                itemBuilder: (_, i) {
                  final ing = _ingresos[i];
                  final raw = ing['ingreso_monto'];
                  final monto = raw is num
                      ? raw.toDouble()
                      : double.tryParse(raw.toString()) ?? 0.0;

                  final categoriaNombre = _categorias.firstWhere(
                        (cat) => cat.categoriaId == ing['categoria_id'],
                    orElse: () => Categoria(
                      categoriaId: 0,
                      categoriaNom: 'Sin categoría',
                      categoriaDescrip: '',
                      iconRef: '',
                      ownerId: null,
                    ),
                  ).categoriaNom;

                  final periodoNombre = periodos[ing['periodo_id']];
                  final descripcion = periodoNombre != null
                      ? '$categoriaNombre • $periodoNombre'
                      : categoriaNombre;

                  return CardItem(
                    title: ing['ingreso_nombre'] as String,
                    subtitle: descripcion,
                    amount: 'RD\$${monto.toStringAsFixed(2)}',
                    onEdit: () => _onEditIngreso(
                      (ing['ingreso_id']).toString(),
                    ),
                    onDelete: () => _onDeleteIngreso(
                      (ing['ingreso_id']).toString(),
                      ing['ingreso_nombre'] as String,
                    ),
                  );
                },
              ),
            ),
          ),

          // Botón Agregar Ingreso
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: '+  Agregar Ingreso',
              style: 'primary',
              onPressed: _onAgregarIngreso,
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class _SmallStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _SmallStatCard({
    Key? key,
    required this.label,
    required this.value,
    this.icon = Icons.circle,
    this.iconColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
