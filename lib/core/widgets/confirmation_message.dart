import 'package:flutter/material.dart';

import '../themes/button_theme.dart';
import 'custom_button.dart';

class ConfirmationMessage extends StatelessWidget {
  final String controllerName;

  const ConfirmationMessage({required this.controllerName,super.key});

  @override
    Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.all(18),
        width: 600,
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
              Icon(
                Icons.check_circle,
                size: 50,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Text(
                '¡$controllerName guardado con éxito!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [

                      Expanded(
                          child: CustomButton(
                            text: 'Aceptar',
                            style: 'primary',
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Boton presionado")),
                              );
                            },
                          ),
                      ),

                      SizedBox(width: 10),


                      Expanded(
                          child: CustomButton(
                            text: 'Cancelar',
                            style: 'secondary',
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Boton presionado")),
                              );
                            },
                          ),
                      ),

                    ],
                ),

              ),

            ],

          ),

        ),

      );
    }
  }
