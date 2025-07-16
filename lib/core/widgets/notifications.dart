import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool _isSwitched = false;

  final List<String> dropdownMenuEntries = [
    '100%',
    '75%',
    '50%',
    '25%',
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
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
              Icon(Icons.notification_add, color: Theme.of(context).colorScheme.primary,),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alerta',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    'Active las notificaciones',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.7)
                    ),
                  ),
                ],
              ),
            ],
          ),

          //SizedBox(height: 20,),

          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(3),

            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Text(
                        'Activar Alertas',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                      Text(
                        'Recibe notificaciones de tu presupuesto',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer
                        ),
                      ),


                    ],
                  ),
                ),

                Switch(
                  value: _isSwitched,
                  onChanged: (value){
                    setState(() {
                      _isSwitched = value;
                      //print(_isSwitched);
                    });
                  },
                ),



              ],
            ),


          ),

          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(3),

            ),
            
            child: DropdownMenu(
              hintText: 'Selecciona una opción',
              width: double.infinity,
                textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                // TODO : desplegable size ajustar
                menuStyle: MenuStyle(

                ),
                dropdownMenuEntries: dropdownMenuEntries.map((e) => DropdownMenuEntry(value: e, label: e)).toList(),

            )

          )

        ]
      )



    );
  }
}
