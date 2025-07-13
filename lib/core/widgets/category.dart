

import 'package:flutter/material.dart';


class Category extends StatefulWidget {
  final List<String> title;
  final List<IconData> icon;

  const Category({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
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

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(3),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /*
            // TODO : Arreglar los titulso estos del demonio
            Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
            ),
            */
            Text(
              'Categorías',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              // TODO: cambiar color
              'Selecciona una categoría',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(

              ),
            ),

            // TODO : hacer que se pueda deseleccionar una categoria si se da click en ella misma
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // opcional
              children: List.generate(widget.title.length, (index) {
                final selected = index == _selectedCatIndex;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCatIndex = index),
                  child: Container(
                    padding: EdgeInsets.all(4),
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
                        Icon(
                          widget.icon[index],
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(height: 3),
                        Text(
                          widget.title[index],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
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



