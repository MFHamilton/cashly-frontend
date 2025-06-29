import 'package:cashly/core/themes/app_themes.dart';
import 'package:cashly/core/themes/text_scheme.dart';
import 'package:cashly/feautures/auth/presentation/login.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: AppTheme.lightTheme,
      home: LoginPage(),
    );
  }
}