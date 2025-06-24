
import 'package:cashly/core/widgets/input.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Los controladores utilizadoss para almacenar(o controlar) la informacion ingresada para
  // su vaildacion
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Luego de que el widget se destruya, liberar recursos
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
            Column(
              children: [
                CustomInputField(
                  controller: emailController,
                  hintText: "Email",), // Input de email
                SizedBox(height: 40),
                CustomInputField(
                  controller: passwordController,
                  hintText: "Contraseña",
                  obscureText: true,), // Input de contrasenia
              ],
            ),
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
