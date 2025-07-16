import 'package:cashly/core/widgets/menu.dart';
import 'package:cashly/feautures/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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



              IconButton(
                icon: const Icon(Icons.account_circle_outlined, size: 28,),
                onPressed: () {

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
