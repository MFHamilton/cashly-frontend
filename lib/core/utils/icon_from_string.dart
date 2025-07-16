import 'package:flutter/material.dart';

IconData getIconFromString(String iconRef) {
  switch (iconRef) {
  // 🏠 Hogar y servicios
    case 'Icons.house':
      return Icons.house;
    case 'Icons.water_drop':
      return Icons.water_drop;
    case 'Icons.lightbulb':
      return Icons.lightbulb;
    case 'Icons.wifi':
      return Icons.wifi;
    case 'Icons.chair':
      return Icons.chair;
    case 'Icons.cleaning_services':
      return Icons.cleaning_services;

  // 🍽️ Alimentación y bebidas
    case 'Icons.fastfood':
      return Icons.fastfood;
    case 'Icons.local_dining':
      return Icons.local_dining;
    case 'Icons.local_cafe':
      return Icons.local_cafe;
    case 'Icons.liquor':
      return Icons.liquor;
    case 'Icons.icecream':
      return Icons.icecream;
    case 'Icons.set_meal':
      return Icons.set_meal;

  // 🚗 Transporte y movilidad
    case 'Icons.directions_bus':
      return Icons.directions_bus;
    case 'Icons.directions_car':
      return Icons.directions_car;
    case 'Icons.local_gas_station':
      return Icons.local_gas_station;
    case 'Icons.train':
      return Icons.train;
    case 'Icons.airplanemode_active':
      return Icons.airplanemode_active;
    case 'Icons.pedal_bike':
      return Icons.pedal_bike;

  // 💼 Trabajo y educación
    case 'Icons.work':
      return Icons.work;
    case 'Icons.school':
      return Icons.school;
    case 'Icons.computer':
      return Icons.computer;
    case 'Icons.book':
      return Icons.book;
    case 'Icons.workspace_premium':
      return Icons.workspace_premium;

  // 🛍️ Compras y personales
    case 'Icons.shopping_cart':
      return Icons.shopping_cart;
    case 'Icons.shopping_bag':
      return Icons.shopping_bag;
    case 'Icons.spa':
      return Icons.spa;
    case 'Icons.sports_esports':
      return Icons.sports_esports;
    case 'Icons.watch':
      return Icons.watch;
    case 'Icons.local_mall':
      return Icons.local_mall;

  // ❤️ Salud y bienestar
    case 'Icons.health_and_safety':
      return Icons.health_and_safety;
    case 'Icons.medical_services':
      return Icons.medical_services;
    case 'Icons.fitness_center':
      return Icons.fitness_center;
    case 'Icons.local_pharmacy':
      return Icons.local_pharmacy;
    case 'Icons.emoji_emotions':
      return Icons.emoji_emotions;

  // 🎉 Ocio y entretenimiento
    case 'Icons.movie':
      return Icons.movie;
    case 'Icons.music_note':
      return Icons.music_note;
    case 'Icons.sports_soccer':
      return Icons.sports_soccer;
    case 'Icons.celebration':
      return Icons.celebration;
    case 'Icons.restaurant_menu':
      return Icons.restaurant_menu;

  // 💸 Finanzas y transferencias
    case 'Icons.attach_money':
      return Icons.attach_money;
    case 'Icons.money_off':
      return Icons.money_off;
    case 'Icons.trending_up':
      return Icons.trending_up;
    case 'Icons.credit_card':
      return Icons.credit_card;
    case 'Icons.savings':
      return Icons.savings;
    case 'Icons.account_balance_wallet':
      return Icons.account_balance_wallet;

  // Otros / por defecto
    case 'Icons.bolt':
      return Icons.bolt;
    case 'Icons.more_horiz':
      return Icons.more_horiz;

    default:
      return Icons.category; // Ícono genérico por defecto
  }
}

const List<String> iconRefs = [
  'Icons.house',
  'Icons.water_drop',
  'Icons.lightbulb',
  'Icons.wifi',
  'Icons.chair',
  'Icons.cleaning_services',
  'Icons.fastfood',
  'Icons.local_dining',
  'Icons.local_cafe',
  'Icons.liquor',
  'Icons.icecream',
  'Icons.set_meal',
  'Icons.directions_bus',
  'Icons.directions_car',
  'Icons.local_gas_station',
  'Icons.train',
  'Icons.airplanemode_active',
  'Icons.pedal_bike',
  'Icons.work',
  'Icons.school',
  'Icons.computer',
  'Icons.book',
  'Icons.workspace_premium',
  'Icons.shopping_cart',
  'Icons.shopping_bag',
  'Icons.spa',
  'Icons.sports_esports',
  'Icons.watch',
  'Icons.local_mall',
  'Icons.health_and_safety',
  'Icons.medical_services',
  'Icons.fitness_center',
  'Icons.local_pharmacy',
  'Icons.emoji_emotions',
  'Icons.movie',
  'Icons.music_note',
  'Icons.sports_soccer',
  'Icons.celebration',
  'Icons.restaurant_menu',
  'Icons.attach_money',
  'Icons.money_off',
  'Icons.trending_up',
  'Icons.credit_card',
  'Icons.savings',
  'Icons.account_balance_wallet',
  'Icons.bolt',
  'Icons.more_horiz',
];
