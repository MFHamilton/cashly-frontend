import 'package:cashly/core/widgets/menu.dart';
import 'package:cashly/feautures/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../feautures/auth/presentation/login.dart';
import '../services/auth_service.dart';

class Header extends StatelessWidget  implements PreferredSizeWidget {


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: kToolbarHeight + 20,

      flexibleSpace: SafeArea(

        child: Container(

          width: double.infinity,
          padding: const EdgeInsets.only(top: 16, left: 25, right: 25),

          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween, // íconos a los lados
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              IconButton(
                icon: const Icon(Icons.menu, size: 28,),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                color: Theme.of(context).colorScheme.primary,
              ),

              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: SvgPicture.asset(
                  'assets/svg/logoHeader01.svg',
                  width: 80,
                ),

              ),



              PopupMenuButton<int>(
                icon: const Icon(Icons.settings_outlined, size: 28),
                color: Theme.of(context).colorScheme.primary,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                onSelected: (int result) async {
                  if (result == 1) {
                    // Ir al perfil
                    /*
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => PerfilPage()),
                    );

                     */
                  } else if (result == 2) {
                    // Cerrar sesión
                    await AuthService().logout(); // 👈 este método deberías tenerlo definido

                    // Si usas almacenamiento local para tokens o datos
                    // final prefs = await SharedPreferences.getInstance();
                    // await prefs.clear();

                    // Redirigir al login (y remover el historial)
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                          (route) => false,
                    );
                  }
                },

                itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text(
                        'Perfil',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Text(
                      'Cerrar Sesión',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),

                ],
              )

            ],
          ),
        ),
      ),
    );

  }
}
