import 'package:cashly/core/widgets/input.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/header.dart';
import '../../core/widgets/menu.dart';

class Profile extends StatelessWidget {
  final TextEditingController name ;

  const Profile({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const MenuLateralScreen(),
      appBar: Header(),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(16),
              height: kToolbarHeight,
              color: Colors.transparent,

              child: Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF28523A)),
                        onPressed: () => Navigator.of(context).pop()
                    ),
                    const SizedBox(width: 8),

                    Text(
                      'Perfil',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        //fontWeight: FontWeight.bold,
                      ),

                    )
                  ]
              )


          ),

          CustomInputField(
              controller: name,
            hintText: 'Nombre',
            readOnly: true,
          )

        ],



      ),
    );
  }
}
