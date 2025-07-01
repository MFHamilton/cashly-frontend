import 'package:cashly/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 32), // Padding Interno del Container
              child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      "Bievenido a Cashly",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text('Tu dinero, tu control. Administra tus finanzas de forma inteligente y segura.'),
                  CustomButton(text: 'Comenzar'),

                ]

              ),
            ),
          ],
        ),

      ),
    );
  }
}
