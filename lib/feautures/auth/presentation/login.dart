
import 'package:cashly/core/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
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

            Container(

              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 32), // Padding Interno del Container

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    'Correo Electrónico',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.surface
                    ),
                  ),
                  SizedBox(height: 8),
                  CustomInputField(
                    controller: emailController,
                    hintText: "Email",
                  ),

                  SizedBox(height: 30),

                  Text(
                    'Contraseña',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.surface
                    ),

                  ),
                  SizedBox(height: 8),
                  CustomInputField(
                    controller: passwordController,
                    hintText: "Contraseña",
                    obscureText: true,
                  ),

                  SizedBox(height: 7),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.surface
                      ),


                    ),
                  ),

                  SizedBox(height: 30),


                  CustomButton(
                    text: 'Iniciar sesión',
                    onPressed: () {
                      print('Botón presionado');
                    },
                  ),

                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '¿No tienes cuenta aún? Regístrate Aquí',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.surface
                      ),
                    ),
                  ),

                  SizedBox(height: 15), // Espacio entre texto y divider

                  Container(
                      width: double.infinity,
                      child: Column(


                        children: [
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.white, // Cambia si tu fondo no es verde oscuro
                                  //indent: 10,
                                  endIndent: 10,
                                ),
                              ),
                              Text(
                                'ó',
                                style: TextStyle(color: Colors.white), // O el color que uses para el texto
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.white,
                                  indent: 10,
                                  //endIndent: 10,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 15), // Espacio entre divider y google btn
                          // with custom text
                          SignInButton(
                            Buttons.google,
                            text: "Ingresa con Google",
                            onPressed: () {},
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                          ),
                        ],
                      )
                  )

                ],
              ),
            ),


          ],
        ),
      ),


    );

  }
}
