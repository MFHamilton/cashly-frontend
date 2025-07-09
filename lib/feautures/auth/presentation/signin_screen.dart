import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../../../core/widgets/input.dart';
import '../../../core/widgets/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cashly/core/themes/text_scheme.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controladores para los campos de texto
  final MyTextTheme _myTextTheme = MyTextTheme();
  final _nombreCtrl = TextEditingController();
  final _apellidoCtrl = TextEditingController();
  final _correoCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  // Estado interno
  DateTime? _fechaNacimiento;
  String? _paisSeleccionado;
  String? _monedaSeleccionada;

  // Listas para los dropdowns
  final _paises = ['República Dominicana', 'Estados Unidos'];
  final _monedas = ['DOP', 'USD'];

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _apellidoCtrl.dispose();
    _correoCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  Future<void> _selectFechaNacimiento() async {
    final hoy = DateTime.now();
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaNacimiento ?? DateTime(hoy.year - 18),
      firstDate: DateTime(1900),
      lastDate: hoy,
    );
    if (fecha != null) {
      setState(() => _fechaNacimiento = fecha);
    }
  }

  void _onRegisterPressed() {
    // TODO: validar campos y llamar a tu servicio de registro
    print('Registrar con: '
        'nombre=${_nombreCtrl.text}, '
        'apellido=${_apellidoCtrl.text}, '
        'correo=${_correoCtrl.text}, '
        'fecha=$_fechaNacimiento, '
        'pais=$_paisSeleccionado, '
        'moneda=$_monedaSeleccionada');
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat.yMMMMd('es');
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 05),
              child: SvgPicture.asset('assets/logotype/Registrate.svg'),
            ),
          ),

              const SizedBox(height: 24),

              // Nombre
              Text('Nombre',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white)),
              const SizedBox(height: 8),
              CustomInputField(
                controller: _nombreCtrl,
                hintText: 'Nombre',
              ),

              const SizedBox(height: 16),
              // Apellido
              Text('Apellido',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white)),
              const SizedBox(height: 8),
              CustomInputField(
                controller: _apellidoCtrl,
                hintText: 'Apellido',
              ),

              const SizedBox(height: 16),
              // Correo
              Text('Correo Electrónico',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white)),
              const SizedBox(height: 8),
              CustomInputField(
                controller: _correoCtrl,
                hintText: 'Correo Electrónico',
              ),

              const SizedBox(height: 16),
              // Fecha de Nacimiento y País en fila
              Row(
                children: [
                  // Fecha
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fecha de Nacimiento',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white)),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: _selectFechaNacimiento,
                          child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _fechaNacimiento == null
                                      ? 'Selecciona fecha'
                                      : fmt.format(_fechaNacimiento!),
                                  style: TextStyle(
                                      color: _fechaNacimiento == null
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                                const Icon(Icons.calendar_today, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),
                  // País
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('País',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: const Text('Selecciona país'),
                              value: _paisSeleccionado,
                              items: _paises
                                  .map((p) => DropdownMenuItem(
                                value: p,
                                child: Text(p),
                              ))
                                  .toList(),
                              onChanged: (v) =>
                                  setState(() => _paisSeleccionado = v),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              // Moneda
              Text('Moneda',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text('Selecciona moneda'),
                    value: _monedaSeleccionada,
                    items: _monedas
                        .map((m) => DropdownMenuItem(
                      value: m,
                      child: Text(m),
                    ))
                        .toList(),
                    onChanged: (v) => setState(() => _monedaSeleccionada = v),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              // Contraseña
              Text('Contraseña',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white)),
              const SizedBox(height: 8),
              CustomInputField(
                controller: _passwordCtrl,
                hintText: 'Contraseña',
                obscureText: true,
              ),

              const SizedBox(height: 16),
              // Confirmar contraseña
              Text('Confirmar Contraseña',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white)),
              const SizedBox(height: 8),
              CustomInputField(
                controller: _confirmPasswordCtrl,
                hintText: 'Confirmar Contraseña',
                obscureText: true,
              ),

              const SizedBox(height: 24),
              // Botón Registrar
              CustomButton(
                text: 'Registrar',
                onPressed: _onRegisterPressed,
              ),

              const SizedBox(height: 16),
              // Link a login
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    '¿Ya tienes una cuenta? Ingresa aquí',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              // Divider con “ó”
              Row(
                children: const [
                  Expanded(
                      child: Divider(color: Colors.white, thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('ó', style: TextStyle(color: Colors.white)),
                  ),
                  Expanded(
                      child: Divider(color: Colors.white, thickness: 1)),
                ],
              ),

              const SizedBox(height: 15),
              // Botón Google
              SignInButton(
                Buttons.google,
                text: 'Regístrate con Google',
                onPressed: () {
                  // TODO: integrar Google Sign-In
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
