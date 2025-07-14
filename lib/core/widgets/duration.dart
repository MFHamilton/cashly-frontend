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
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(3)
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Text(
              'Duración',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary
            ),
          ),

          SizedBox(height: 20,),

          TextField(
            controller: widget.dateStartController,
            decoration: InputDecoration(
              labelText: 'Fecha de Inicio',
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

