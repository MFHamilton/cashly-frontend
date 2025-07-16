import 'package:flutter/material.dart';

import '../themes/button_theme.dart';
import 'custom_button.dart';

class ConfirmationMessage extends StatelessWidget {
  final String controllerName;
  final Widget targetRoute;

  const ConfirmationMessage({
    required this.controllerName,
    required this.targetRoute,
    super.key
  });

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
                '¡$controllerName guardado con éxitoo!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // TODO : Probar si se pueden poner los botones mas peque;os
                    children: [

                      Expanded(
                          child: CustomButton(
                            text: 'Aceptar',
                            style: 'primary',
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => targetRoute),
                              );
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
                              Navigator.of(context).pop();
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
