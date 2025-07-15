import 'package:cashly/core/models/ingreso.dart';
import 'package:cashly/core/widgets/category.dart';
import 'package:cashly/core/widgets/confirmation_message.dart';
import 'package:cashly/core/widgets/delete_message.dart';
import 'package:cashly/core/widgets/form_input.dart';
import 'package:cashly/core/widgets/frecuency.dart';
import 'package:cashly/core/widgets/duration.dart';
import 'package:flutter/material.dart';
import 'package:cashly/core/widgets/notifications.dart';

import '../../core/widgets/notifications.dart';

class _TestingPageState extends State<TestingPage> {
  final TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Notifications(),




      ),
    );
  }
}

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}
