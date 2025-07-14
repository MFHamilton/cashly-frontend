import 'package:flutter/material.dart';

class IconHelper {
  // Iconos disponibles para que el usuario elija
  static const Map<String, IconData> availableIcons = {
    // Iconos generales que todos tendrán
    'home': Icons.home,
    'work': Icons.work,
    'shopping': Icons.shopping_cart,
    'food': Icons.restaurant,
    'health': Icons.health_and_safety,
    'travel': Icons.flight,
    'entertainment': Icons.movie,
    'sports': Icons.sports_soccer,
    'money': Icons.attach_money,
    'education': Icons.school,
    'transport': Icons.directions_car,
    'family': Icons.family_restroom,
    'fitness': Icons.fitness_center,
    'music': Icons.music_note,
    'pets': Icons.pets,
    'tools': Icons.build,
    'calendar': Icons.calendar_today,
    'star': Icons.star,
    'favorite': Icons.favorite,
    'settings': Icons.settings,
    // Agrega más según necesites
  };

  // Método para obtener el icono
  static IconData getIcon(String iconKey) {
    return availableIcons[iconKey] ?? Icons.help_outline;
  }

  // Obtener la lista de iconos disponibles para el selector
  static List<String> getAvailableIconKeys() {
    return availableIcons.keys.toList();
  }
}