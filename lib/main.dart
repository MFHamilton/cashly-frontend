import 'package:cashly/core/themes/app_themes.dart';
import 'package:cashly/feautures/intro/presentation/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: AppTheme.lightTheme,
      home: IntroPage(),
    );
  }
}
