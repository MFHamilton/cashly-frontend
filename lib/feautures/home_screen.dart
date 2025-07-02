import 'package:cashly/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: Stack(
            children: [
              // Botón izquierdo
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    // Acción del botón izquierdo
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Menú presionado")),
                    );
                  },
                  color: AppColors.primary,
                ),
              ),
              // Imagen centrada
              Center(
                child: SvgPicture.asset(
                  'assets/logotype/whiteLogo.svg',
                  color: AppColors.secondary,
                  width: 100,
                ),
              ),
              // Botón derecho
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.account_circle_outlined),
                  onPressed: () {
                    // Acción del botón derecho
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Perfil presionado")),
                    );
                  },
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                children: [
                  CustomCard(
                    titleIcon: Icons.account_circle_outlined,
                    cardTitle: "Lorem ipsum",
                    amount: 30000,
                    bottomContent: "+5% al mes anterior",
                  ),

                  CustomCard(
                    titleIcon: Icons.account_circle_outlined,
                    cardTitle: "Lorem ipsum",
                    amount: 30000,
                    bottomContent: "+5% al mes anterior",
                  ),

                  CustomCard(
                    titleIcon: Icons.account_circle_outlined,
                    cardTitle: "Lorem ipsum",
                    amount: 30000,
                    bottomContent: "+5% al mes anterior",
                  ),

                  CustomCard(
                    titleIcon: Icons.account_circle_outlined,
                    cardTitle: "Lorem ipsum",
                    amount: 30000,
                    bottomContent: "+5% al mes anterior",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.titleIcon,
    required this.cardTitle,
    required this.amount,
    required this.bottomContent,
  });

  final IconData titleIcon;
  final String cardTitle;
  final double amount;
  final String bottomContent;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Bordes redondeados
      ),
      color: Colors.grey[300],
      elevation: 4,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Title row
            Row(
              children: [
                Icon(titleIcon, color: AppColors.secondary),
                SizedBox(width: 20),
                Text(
                  cardTitle,
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 20),
                ),
              ],
            ),
            // Content row
            Row(
              children: [
                Text(
                  "RD\$ ${amount.toStringAsFixed(2)}",
                  style: TextStyle(color: AppColors.primary, fontSize: 30),
                ),
              ],
            ),
            // Bottom row
            Row(
              children: [
                Text(
                  bottomContent,
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
