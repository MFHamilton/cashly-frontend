import 'package:flutter/material.dart';

class Duration extends StatefulWidget {
  Duration({
    super.key,
    required this.dateStartController,
    required this.dateEndController,
  });

  final TextEditingController dateStartController;
  final TextEditingController dateEndController;

  @override
  State<Duration> createState() => _DurationState();
}

class _DurationState extends State<Duration> {

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 300 ,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(3)
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, color: Theme.of(context).colorScheme.primary,),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Duración',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary
                    ),
                  ),
                  Text(
                    'Selecciona la duración de la frecuencia',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.7)
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 12,),

          TextField(
            controller: widget.dateStartController,
            decoration: InputDecoration(
              labelText: 'Fecha de Inicio',
                labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
                ),
              filled: true,
              prefixIcon: Icon(Icons.calendar_month),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
              )
            ),
            readOnly: true,
            onTap: (){
              _selectDate(widget.dateStartController);
            },
          ),

          SizedBox(height: 20,),

          TextField(
            controller: widget.dateEndController,
            decoration: InputDecoration(
                labelText: 'Fecha de Fin (Opcional)',
                labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
                ),
                filled: true,
                prefixIcon: Icon(Icons.calendar_month),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
                )
            ),
            readOnly: true,
            onTap: (){
              _selectDate(widget.dateEndController);
            },
          ),

          Padding(
            padding: EdgeInsets.only( bottom: 10),
          ),
        ],
      ),


      
    );
    

  }

  Future<void> _selectDate(TextEditingController controller) async{
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
    );

    if (_picked != null){
      setState(() {
        controller.text = _picked.toString().split(" ")[0];

      });
    }
  }
}

