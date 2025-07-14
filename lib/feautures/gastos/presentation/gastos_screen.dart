import 'package:cashly/core/constants/app_color.dart';
import 'package:cashly/core/models/gastos.dart';
import 'package:cashly/core/widgets/header.dart';
import 'package:cashly/core/widgets/menu.dart';
import 'package:cashly/feautures/gastos/presentation/add_gasto_screen.dart';
import 'package:cashly/feautures/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/themes/text_scheme.dart';

// StatefulWidget
class GastosScreen extends StatefulWidget {
  const GastosScreen({Key? key}) : super(key: key); // Add a constructor

  @override
  State<GastosScreen> createState() => _GastosScreenState();
}

// State class
class _GastosScreenState extends State<GastosScreen>{

  void _onAgregarGasto() {

  }

  void _onEditGasto(String gastoId) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6F9F3),
        drawer: const MenuLateralScreen(),
        appBar: Header(),
        body: Column(
          children: [
          // — Aquí va tu "AppBar manual" debajo del Header —
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
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
              ),
              const Spacer(),
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/user.svg',
                  width: 24,
                  height: 24,
                  color: Color(0xFF28523A),
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
                      Icon(Icons.attach_money, color: Theme.of(context).colorScheme.primary),
                      SizedBox(width: 8),
                      Text('Gastos Totales',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600)),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text('Julio 2025', style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                  SizedBox(height: 12),
                  Text('RD\$5,000',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                  Text('Este mes', style: TextStyle(color: Theme.of(context).colorScheme.primary.withOpacity(0.7))),
                ],
              ),
            ),
          ),

          // Stats pequeños: Activos / Pérdida
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _SmallStatCard(
                  label: 'Activos',
                  value: '6',
                  iconColor: Color(0xFFB5D4B1),
                ),
                SizedBox(width: 12),

              ],
            ),
          ),

          // TODO: convertir esto a un componente
          // Lista de gastos recientes
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView(
                children: [
                  _cardItem(
                    title: 'Colegio',
                    subtitle: 'Hijo · Mensual',
                    amount: 'RD\$50,000.00',
                    onEdit: () => _onEditGasto('colegio'),
                  ),
                  _cardItem(
                    title: 'Super',
                    subtitle: 'Casa · Semanal',
                    amount: 'RD\$50,000.00',
                    onEdit: () => _onEditGasto('super'),
                  ),
                  _cardItem(
                    title: 'Salón',
                    subtitle: 'Personal · Quincenal',
                    amount: 'RD\$50,000.00',
                    onEdit: () => _onEditGasto('salon'),
                  ),
                  _cardItem(
                    title: 'Uñas',
                    subtitle: 'Personal · Quincenal',
                    amount: 'RD\$50,000.00',
                    onEdit: () => _onEditGasto('uñas'),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),

          // Botón Agregar Gasto
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: '+  Agregar Gasto',
              style: 'primary',
              onPressed: () {   // aquí sólo la función anónima, sin llaves extra
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AgregarGastoScreen(),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 15,),
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
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12)),
                Text(value, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class _cardItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final VoidCallback onEdit;

  const _cardItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(Icons.arrow_upward, color: Color(0xFFB5D4B1)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: MyTextTheme.lightTextTheme.titleSmall),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(amount,
                style: Theme.of(context).textTheme.titleMedium?.copyWith()),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.secondary),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.secondary),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
