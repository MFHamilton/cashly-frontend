import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/header.dart';
import '../../core/themes/text_scheme.dart';
import '../../core/widgets/custom_button.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: probar boton para ir al home page
            Container(
              width: 80,
              padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: InkWell(
                onTap: () {
                  if (kDebugMode) {
                    print("Ir al home page");
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios),
                    SizedBox(width: 4),
                    Text("Metas", style: MyTextTheme.lightTextTheme.bodyLarge),
                  ],
                ),
              ),
            ),
            // TODO: card general de metas
            // TODO: lista de cada meta
            // TODO: boton para agregar meta
            CustomButton(text: "Agregar Meta"),
          ],
        ),
      ),
    );
  }
}
