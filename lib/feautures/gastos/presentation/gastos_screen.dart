import 'package:cashly/core/constants/app_color.dart';
import 'package:cashly/core/services/gastos_service.dart';       // ← nuevo
import 'package:cashly/core/widgets/delete_message.dart';
import 'package:cashly/core/widgets/header.dart';
import 'package:cashly/core/widgets/menu.dart';
import 'package:cashly/feautures/gastos/presentation/add_gasto_screen.dart';
import 'package:cashly/feautures/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/cardItem.dart';

class GastosScreen extends StatefulWidget {
  const GastosScreen({Key? key}) : super(key: key);

  @override
  State<GastosScreen> createState() => _GastosScreenState();
}

class _GastosScreenState extends State<GastosScreen>{
  final _service = GastosService();         // servicio
  bool _loading = true;                     // estado de carga
  List<dynamic> _gastos = [];               // gastos traídos

  final String mesAnio = toBeginningOfSentenceCase(
      DateFormat('MMMM yyyy', 'es_ES').format(DateTime.now())
  )!;

  @override
  void initState() {
    super.initState();
    _fetchGastos();
  }

  Future<void> _fetchGastos() async {
    setState(() => _loading = true);
    try {
      final now = DateTime.now();
      _gastos = await _service.getGastos(
        month: now.month,
        year: now.year,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _loading = false);
    }
  }

  double get totalMes => _gastos.fold(0.0, (sum, g) {
    final raw = g['gasto_monto'];
    // si viene como número lo tomamos directo, si viene como String lo parseamos
    final monto = raw is num
        ? raw.toDouble()
        : double.tryParse(raw.toString()) ?? 0.0;
    return sum + monto;
  });

  void _onAgregarGasto() async {
    await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const AgregarGastoScreen())
    );
    _fetchGastos();
  }

  void _onEditGasto(String gastoId) {

  }

  void _onDeleteGasto(String gastoId) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: DeleteMessage(
          controllerName: gastoId,
          targetRoute: const GastosScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9F3),
      drawer: const MenuLateralScreen(),
      appBar: Header(),
      body: Column(
        children: [
          // — "AppBar manual" debajo del Header —
          Container(
            height: kToolbarHeight,
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF28523A)),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Gastos',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
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

          // Tarjeta de Gastos Totales
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
                      Icon(Icons.attach_money,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Gastos Totales',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
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
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                _SmallStatCard(
                  label: 'Activos',
                  value: '6',
                  iconColor: Color(0xFFB5D4B1),
                ),
                SizedBox(width: 12),

              ],
            ),
          ),

          // Lista de gastos recientes (dinámica)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _gastos.isEmpty
                  ? const Center(child: Text('No hay gastos este mes'))
                  : ListView.builder(
                itemCount: _gastos.length,
                itemBuilder: (_, i) {
                  final g = _gastos[i];
                  final raw = g['gasto_monto'];
                  final monto = raw is num
                      ? raw.toDouble()
                      : double.tryParse(raw.toString()) ?? 0.0;

                  final fecha = g['gasto_fecha'] != null
                      ? DateFormat('d MMM', 'es_ES').format(
                      DateTime.parse(g['gasto_fecha'] as String))
                      : '';

                  return CardItem(
                    title: g['gasto_nombre'] as String,
                    subtitle: fecha,
                    amount: 'RD\$${monto.toStringAsFixed(2)}',
                    onEdit: () => _onEditGasto((g['gasto_id']).toString()),
                    onDelete: () => _onDeleteGasto((g['gasto_nombre']).toString()),
                  );
                },

              ),
            ),
          ),

          // Botón Agregar Gasto
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: '+  Agregar Gasto',
              style: 'primary',
              onPressed: _onAgregarGasto,
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
                Text(label,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 12)),
                Text(value,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



