import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          text: 'Iniciar sesión',
          onPressed: () {
            print('Botón presionado');
          },
        ),
      ),
    );
  }
}
