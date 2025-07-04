import 'package:cashly/core/constants/app_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController paisController = TextEditingController();
  final TextEditingController monedaController = TextEditingController();

  DateTime? fechaNacimiento;

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    correoController.dispose();
    passwordController.dispose();
    paisController.dispose();
    monedaController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != fechaNacimiento) {
      setState(() {
        fechaNacimiento = picked;
      });
    }
  }

  void register() {
    if (fechaNacimiento == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor selecciona tu fecha de nacimiento")),
      );
      return;
    }

    if (kDebugMode) {
      print({
      "usuario_nombre": nombreController.text,
      "usuario_apellido": apellidoController.text,
      "usuario_correo": correoController.text,
      "usuario_password": passwordController.text,
      "usuario_pais": paisController.text,
      "usuario_moneda": monedaController.text,
      "usuario_fecha_nacimiento": fechaNacimiento!.toIso8601String(),
    });
    }

    // TODO: llamar el servicio
  }

  @override
  Widget build(BuildContext context) {
    Widget buildLabel(String text) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              SvgPicture.asset('assets/logotype/whiteLogo.svg'),
              SizedBox(height: 40),

              buildLabel("Nombre"),
              CustomInputField(
                controller: nombreController,
                hintText: "Nombre",
              ),

              SizedBox(height: 16),
              buildLabel("Apellido"),
              CustomInputField(
                controller: apellidoController,
                hintText: "Apellido",
              ),

              SizedBox(height: 16),
              buildLabel("Correo Electrónico"),
              CustomInputField(
                controller: correoController,
                hintText: "Correo Electrónico",
              ),

              SizedBox(height: 16),
              buildLabel("País"),
              CustomInputField(controller: paisController, hintText: "País"),

              SizedBox(height: 16),
              buildLabel("Moneda (opcional)"),
              CustomInputField(
                controller: monedaController,
                hintText: "Moneda",
              ),

              SizedBox(height: 16),
              buildLabel("Fecha de nacimiento"),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    fechaNacimiento != null
                        ? "${fechaNacimiento!.day}/${fechaNacimiento!.month}/${fechaNacimiento!.year}"
                        : "Seleccionar fecha",
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                ),
              ),

              SizedBox(height: 30),
              CustomButton(text: 'Registrarse', onPressed: () {}),

              SizedBox(height: 20),
              Text(
                '¿Ya tienes una cuenta? Inicia Sesión',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
