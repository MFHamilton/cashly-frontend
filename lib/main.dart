import 'package:cashly/core/themes/app_themes.dart';
import 'package:cashly/feautures/goals/presentation/add_goal.dart';
import 'package:cashly/feautures/goals/presentation/goals.dart';
import 'package:cashly/feautures/home/presentation/home_screen.dart';
import 'package:cashly/feautures/intro/presentation/intro_page.dart';
import 'package:cashly/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  // await dotenv.load(); // Cargando las variables de entorno

  await initializeDateFormatting('es', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = const FlutterSecureStorage();
    storage.write(key: 'jwt', value: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsImlhdCI6MTc1MjA5NDc2NywiZXhwIjoxNzUyMDk4MzY3fQ.10tkfXAYaSpShY2f1ZnFtNfcAq7jtVXkOKAg62oM0tc");
    return MaterialApp(
      title: 'Material App',
      theme: AppTheme.lightTheme,
      home: AddGoalScreen(),
    );
  }
}
