


class LoginValidator {
  static String? validateEmail(String email) {
    if (email.isEmpty) return 'El correo no puede estar vacío';
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(email)) return 'Formato de email inválido';
    return null;
  }

  static String? validatePassword(String pass) {
    if (pass.isEmpty) return 'La contraseña no puede estar vacía';
    if (pass.length < 6) return 'Mínimo 6 caracteres';
    return null;
  }
}
