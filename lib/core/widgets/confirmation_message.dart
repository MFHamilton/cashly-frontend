import 'package:flutter/material.dart';

import 'custom_button.dart';

class ConfirmationMessage extends StatelessWidget {
  const ConfirmationMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(18),
      width: 500,
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 50, color: Theme.of(context).colorScheme.secondary,),
            Text(
                '¡CONTROLLER guardado con éxito!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary
              ),
            ),

            CustomButton(
              text: 'Aceptar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Boton presionado")),
                );
              },
            ),

          ]

        ),

      ),

    );
  }
}
