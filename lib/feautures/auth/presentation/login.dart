
  import 'package:cashly/core/widgets/input.dart';
import 'package:cashly/feautures/home/presentation/home_screen.dart';
  import 'package:flutter/material.dart';
  import 'package:sign_in_button/sign_in_button.dart';

  import '../../../core/services/auth_service.dart';
import '../../../core/widgets/custom_button.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'signin_screen.dart';


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

    ValueNotifier userCredential = ValueNotifier('');

    final AuthService _authService = AuthService();

    void login() async {
      final correo = emailController.text.trim();
      final password = passwordController.text;

      try{
        await _authService.login(correo: correo, password: password);
      }catch(e){
        print("Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de inicio de sesión')),
        );
        return;
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }


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
                          color: Theme.of(context).colorScheme.surface,
                        fontWeight: FontWeight.w600

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
                          color: Theme.of(context).colorScheme.surface,
                          fontWeight: FontWeight.w600
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
                      onPressed: login,
                      style: "primary",
                    ),

                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          // quitar el padding por defecto si quieres
                          padding: EdgeInsets.zero,
                          // fondo transparente
                          backgroundColor: Colors.transparent,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const RegisterPage()),
                          );
                        },
                        child: Text(
                          '¿No tienes cuenta aún? Regístrate Aquí',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                            decoration: TextDecoration.underline, // opcional
                          ),
                        ),
                      ),
                    ),


                    SizedBox(height: 15), // Espacio entre texto y divider



                  ],
                ),
              ),


            ],
          ),
        ),


      );

    }
  }
