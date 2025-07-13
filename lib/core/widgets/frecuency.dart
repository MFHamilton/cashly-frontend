import 'package:flutter/material.dart';

class Frecuency extends StatefulWidget {
  const Frecuency({super.key});

  @override
  State<Frecuency> createState() => _FrecuencyState();
}

class _FrecuencyState extends State<Frecuency> {
  final _formKey = GlobalKey<FormState>();

  int? _selectedCatIndex;

  void _onRegistrar() {
    if (_formKey.currentState?.validate() ?? false && _selectedCatIndex != null) {
      // TODO: guardar el gasto en tu BD, incluyendo _categorias[_selectedCatIndex!].nombre
      Navigator.of(context).pop();
    } else if (_selectedCatIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selecciona una categoría')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(3),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO : Arreglar los titulso estos del demonio
            Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
            ),

            Text(
              'Frecuencia',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            // TODO : hacer que se pueda deseleccionar una categoria si se da click en ella misma
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 150 / 80,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // opcional
              children: List.generate(6, (index) {
                final selected = index == _selectedCatIndex;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCatIndex = index),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(8), // usa menos margen si hay overflow
                    decoration: BoxDecoration(
                      color: selected
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: selected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.primaryContainer,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                      ],
                    ),
                  ),
                );
              }),
            )

          ],


        )


    );
  }
}
