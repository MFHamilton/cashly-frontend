import 'package:cashly/core/models/ingreso.dart';
import 'package:cashly/core/widgets/category.dart';
import 'package:cashly/core/widgets/confirmation_message.dart';
import 'package:cashly/core/widgets/delete_message.dart';
import 'package:cashly/core/widgets/form_input.dart';
import 'package:cashly/core/widgets/frecuency.dart';
import 'package:cashly/core/widgets/duration.dart';
import 'package:cashly/feautures/gastos/presentation/gastos_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cashly/core/widgets/notifications.dart';

import '../../core/widgets/notifications.dart';

class _TestingPageState extends State<TestingPage> {
  final TextEditingController inputController = TextEditingController();
  static const route = '/testing';
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          children: [
            Text('${message.notification?.title}'),
            Text('${message.notification?.body}'),
            Text('${message.data}'),
          ],
        )

      ),
    );
  }
}

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});
  static const route = '/testing';

  @override
  State<TestingPage> createState() => _TestingPageState();
}
