import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Header extends StatelessWidget  implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;
  final VoidCallback onProfilePressed;

  const Header({
    super.key,
    required this.onMenuPressed,
    required this.onProfilePressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,

      flexibleSpace: SafeArea(

        child: Container(

          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25),

          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween, // íconos a los lados
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Menú presionado")),
                  );
                },
                color: Theme.of(context).colorScheme.primary,
              ),

              SvgPicture.asset(
                'assets/svg/logoHeader01.svg',
                width: 80,
              ),

              IconButton(
                icon: const Icon(Icons.account_circle_outlined),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Perfil presionado")),
                  );
                },
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );

  }
}
