import 'package:cashly/core/widgets/category.dart';
import 'package:cashly/core/widgets/form_input.dart';
import 'package:flutter/material.dart';

class _TestingPageState extends State<TestingPage> {
  final TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          children: [
            Category(
              title: [
                'Comida',
                'Salario',
                'Hogar',
                'Trabajo',


              ],
              icon: [
                Icons.flatware,
                Icons.account_balance,
                Icons.cottage,
                Icons.badge,


              ],
            ),
            Text('pruebaaaa'),
          ],
        ),

      ),
    );
  }
}

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}
