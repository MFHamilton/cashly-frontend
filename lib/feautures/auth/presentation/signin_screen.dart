import 'package:cashly/core/services/auth_service.dart';
import 'package:cashly/feautures/home/presentation/home_screen.dart';
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

  // Servicio de autenticación y estado de carga
  final AuthService _authService = AuthService();
  bool _isLoading = false;

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

  Future<void> _onRegisterPressed() async {
    // Validaciones básicas
    if (_nombreCtrl.text.isEmpty ||
        _apellidoCtrl.text.isEmpty ||
        _correoCtrl.text.isEmpty ||
        _passwordCtrl.text.isEmpty ||
        _confirmPasswordCtrl.text.isEmpty ||
        _passwordCtrl.text != _confirmPasswordCtrl.text ||
        _fechaNacimiento == null ||
        _paisSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos correctamente')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _authService.register(
        nombre: _nombreCtrl.text,
        apellido: _apellidoCtrl.text,
        correo: _correoCtrl.text,
        password: _passwordCtrl.text,
        pais: _paisSeleccionado!,
        moneda: _monedaSeleccionada,
        fechaNacimiento: _fechaNacimiento!,
      );
      Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const HomeScreen())
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _onGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      await _authService.signInWithGoogle();
      if (_authService.currentUser != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Google Sign-In: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    final fmt = DateFormat.yMMMMd('es');

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: SvgPicture.asset('assets/logotype/Registrate.svg'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Nombre
                  Text('Nombre', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                  const SizedBox(height: 8),
                  CustomInputField(controller: _nombreCtrl, hintText: 'Nombre'),

                  const SizedBox(height: 16),
                  // Apellido
                  Text('Apellido', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                  const SizedBox(height: 8),
                  CustomInputField(controller: _apellidoCtrl, hintText: 'Apellido'),

                  const SizedBox(height: 16),
                  // Correo
                  Text('Correo Electrónico', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                  const SizedBox(height: 8),
                  CustomInputField(controller: _correoCtrl, hintText: 'Correo Electrónico'),

                  const SizedBox(height: 16),
                  // Fecha de Nacimiento y País
                  Row(children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fecha de Nacimiento', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: _selectFechaNacimiento,
                          child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    _fechaNacimiento == null ? 'Selecciona fecha' : fmt.format(_fechaNacimiento!),
                                    style: TextStyle(
                                      color: _fechaNacimiento == null ? Colors.grey : Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.calendar_today, size: 18),
                              ],
                            ),
                          ),
                        ),

                      ],
                    )),
                    const SizedBox(width: 16),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('País', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                        SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: const Text('Selecciona país'),
                              value: _paisSeleccionado,
                              items: _paises.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                              onChanged: (v) => setState(() => _paisSeleccionado = v),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ]),

                  const SizedBox(height: 16),
                  // Moneda
                  Text('Moneda', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Selecciona moneda'),
                        value: _monedaSeleccionada,
                        items: _monedas.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                        onChanged: (v) => setState(() => _monedaSeleccionada = v),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  // Contraseña
                  Text('Contraseña', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                  const SizedBox(height: 8),
                  CustomInputField(controller: _passwordCtrl, hintText: 'Contraseña', obscureText: true),

                  const SizedBox(height: 16),
                  // Confirmar contraseña
                  Text('Confirmar Contraseña', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                  const SizedBox(height: 8),
                  CustomInputField(controller: _confirmPasswordCtrl, hintText: 'Confirmar Contraseña', obscureText: true),

                  const SizedBox(height: 24),
                  // Botón Registrar
                  CustomButton(
                    text: _isLoading ? '...' : 'Registrar',
                    style: 'primary',
                    onPressed: _isLoading ? null : _onRegisterPressed,
                  ),

                  const SizedBox(height: 16),
                  // Link a login
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        '¿Ya tienes una cuenta? Ingresa aquí',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white, fontStyle: FontStyle.italic, decoration: TextDecoration.underline),
                      ),
                    ),
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
