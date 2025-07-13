import 'package:cashly/core/models/gastos.dart';
import 'package:cashly/feautures/gastos/add_gasto_screen.dart';
import 'package:cashly/feautures/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/widgets/custom_button.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF28523A)),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen())),

        ),
        title: Text(
          'Gastos',
          style: TextStyle(color: Color(0xFF28523A), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/user.svg', // tu SVG de usuario
              width: 24,
              height: 24,
              color: Color(0xFF28523A),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Tarjeta de Gastos Totales
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFEAF1EA),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.attach_money, color: Color(0xFF28523A)),
                      SizedBox(width: 8),
                      Text('Gastos Totales',
                          style: TextStyle(color: Color(0xFF28523A), fontWeight: FontWeight.w600)),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xFF28523A),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text('Julio 2025', style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                  SizedBox(height: 12),
                  Text('RD\$5,000',
                      style: TextStyle(
                          color: Color(0xFF28523A),
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                  Text('Este mes', style: TextStyle(color: Color(0xFF28523A).withOpacity(0.7))),
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
                  _GastoItem(
                    title: 'Colegio',
                    subtitle: 'Hijo · Mensual',
                    amount: 'RD\$50,000.00',
                    onEdit: () => _onEditGasto('colegio'),
                  ),
                  _GastoItem(
                    title: 'Super',
                    subtitle: 'Casa · Semanal',
                    amount: 'RD\$50,000.00',
                    onEdit: () => _onEditGasto('super'),
                  ),
                  _GastoItem(
                    title: 'Salón',
                    subtitle: 'Personal · Quincenal',
                    amount: 'RD\$50,000.00',
                    onEdit: () => _onEditGasto('salon'),
                  ),
                  _GastoItem(
                    title: 'Uñas',
                    subtitle: 'Personal · Quincenal',
                    amount: 'RD\$50,000.00',
                    onEdit: () => _onEditGasto('uñas'),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // acción ver más
                      },
                      child: Text('Ver más',
                          style: TextStyle(color: Color(0xFF28523A))),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Botón Agregar Gasto
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: '+ Agregar Gasto',
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
                Text(label, style: TextStyle(color: Colors.black54, fontSize: 12)),
                Text(value, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GastoItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final VoidCallback onEdit;

  const _GastoItem({
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
        subtitle: Text(subtitle, style: TextStyle(color: Colors.black54)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(amount,
                style: TextStyle(
                    color: Color(0xFF28523A), fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.edit, color: Color(0xFF28523A)),
              onPressed: onEdit,
            ),
          ],
        ),
      ),
    );
  }
}
