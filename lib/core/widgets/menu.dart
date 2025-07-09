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
      child: ListView(
        padding: const EdgeInsets.only(top: 50),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Icon(Icons.menu, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 20),

          _buildMenuItem(
            title: "Ingresos",
            subItems: ["Reporte de ingresos"],
          ),
          _buildMenuItem(
            title: "Gastos",
            subItems: ["Reporte de gastos"],
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

      //body: const Center(child: Text("Contenido principal")),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required List<String> subItems,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        unselectedWidgetColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
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
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        children: subItems.map((item) {
          return ListTile(
            title: Text(
              item,
              style: const TextStyle(color: Colors.white70),
            ),
            onTap: () {
              // Cerrar el Drawer y navegar
              Navigator.pop(context);
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
