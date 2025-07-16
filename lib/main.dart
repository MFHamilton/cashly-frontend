import 'package:cashly/core/themes/app_themes.dart';

import 'package:cashly/feautures/auth/presentation/login.dart';
import 'package:cashly/feautures/budget/presentation/budget.dart';
import 'package:cashly/feautures/category/presentation/new_category.dart';
import 'package:cashly/feautures/gastos/presentation/gastos_screen.dart';
import 'package:cashly/feautures/goals/presentation/add_goal.dart';
import 'package:cashly/feautures/home/presentation/home_screen.dart';
import 'package:cashly/feautures/intro/presentation/intro_page.dart';
import 'package:cashly/feautures/report/presentation/report.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'feautures/test/testingPage.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  //await dotenv.load(); // Cargando las variables de entorno

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
      //navigatorKey: navigatorKey,
      home: IntroPage(),



    );
  }
}
