import 'package:cashly/core/themes/text_scheme.dart';
import 'package:cashly/core/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Goals extends StatelessWidget {
  const Goals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: probar boton para ir al home page
            InkWell(
              onTap: () {
                if (kDebugMode) {
                  print("Ir al home page");
                }
              },
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  Text("Metas", style: MyTextTheme.lightTextTheme.bodyMedium),
                ],
              ),
            ),
            // TODO: card general de metas
            // TODO: lista de cada meta
            // TODO: boton para agregar meta
            CustomButton(text: "Agregar Meta" ),
          ],
        ),
      ),
    );
  }
}
