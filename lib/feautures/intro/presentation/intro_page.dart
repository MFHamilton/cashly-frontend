import 'package:cashly/core/widgets/custom_button.dart';
import 'package:cashly/feautures/auth/presentation/login.dart';
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
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontFamily: 'Logotype',
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,

                    ),
                  ),
                  //SizedBox(height: 10),
                  Text(
                      'Tu dinero, tu control. Administra tus finanzas de forma inteligente y segura.',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,

                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                      text: 'Comenzar',
                    onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );

                    },
                  ),

                ]

              ),
            ),
          ],
        ),

      ),
    );
  }
}
