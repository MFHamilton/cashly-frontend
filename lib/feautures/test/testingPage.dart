import 'package:cashly/core/widgets/category.dart';
import 'package:cashly/core/widgets/form_input.dart';
import 'package:cashly/core/widgets/frecuency.dart';
import 'package:cashly/core/widgets/duration.dart';
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
            Duration(),
            SizedBox(height: 10,),
            Category(title: [
              'Comida',
              ],
                icon: [
                  Icons.flatware,
                ])
            //Text('pruebaaaa'),
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
