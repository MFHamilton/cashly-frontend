
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';



class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/logotype/whiteLogo.svg'),
            SizedBox(height: 40), // Espacio entre logo y botón
            CustomButton(
              text: 'Iniciar sesión',
              onPressed: () {
                print('Botón presionado');
              },
            ),
          ],
        ),
      ),


    );
  }
}
