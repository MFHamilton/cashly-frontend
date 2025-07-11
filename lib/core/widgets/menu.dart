import 'package:cashly/feautures/gastos/gastos_screen.dart';
import 'package:flutter/material.dart';

class MenuLateralScreen extends StatefulWidget {
  const MenuLateralScreen({super.key});

  @override
  State<MenuLateralScreen> createState() => _MenuLateralScreenState();
}

class _MenuLateralScreenState extends State<MenuLateralScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: ListView(
        padding: const EdgeInsets.only(top: 50),
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.menu, color: Colors.white, size: 28),

              )

          ),

          SizedBox(height: 20),

          _buildMenuItem(
            title: "Ingresos",
            subItems: ["Reporte de ingresos"],
          ),
          _buildMenuItem(
            title: "Gastos",
            subItems: ["Reporte de gastos"],
            navigateto: GastosScreen(),

          ),
          _buildMenuItem(
            title: "Metas",
            subItems: ["Reporte de Metas"],
          ),
          _buildMenuItem(
            title: "Presupuestos",
            subItems: ["Reporte de Presupuestos"],
          ),
        ],
      ),

    );
  }

  Widget _buildMenuItem({
    required String title,
    required List<String> subItems,
    navigateto,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        unselectedWidgetColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Theme.of(context).colorScheme.surface,
        ),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconColor: Theme.of(context).colorScheme.surface,
        collapsedIconColor: Theme.of(context).colorScheme.surface,
        children: subItems.map((item) {
          return ListTile(
            title: Text(
              item,
              style: const TextStyle(color: Colors.white70),
            ),
            onTap: () {
              // Cerrar el Drawer y navegar
              Navigator.pop(context);
              if (navigateto != null) {
               Navigator.of(context).push(
                 MaterialPageRoute(builder: (context) => navigateto),
               );
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Seleccionaste: $item")),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
