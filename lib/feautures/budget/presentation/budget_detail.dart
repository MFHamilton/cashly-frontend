import 'package:flutter/material.dart';

import '../../../core/themes/text_scheme.dart';
import '../../../core/widgets/header.dart';
import '../../../core/widgets/menu.dart';

class BudgetDetail extends StatelessWidget {
  const BudgetDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateralScreen(),
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // titulo de pantalla
            Container(
              width: 110,
              padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(width: 4),
                  Text(
                    "Presupesto",
                    style: MyTextTheme.lightTextTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            // TODO: card con el detalle del presupuesto
            // TODO: opciones de resumen, historial y analisis
            // TODO: renderizar resumen, historial o analisis
          ],
        ),
      ),
    );
  }
}
