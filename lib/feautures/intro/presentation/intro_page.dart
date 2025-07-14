import 'package:cashly/core/widgets/custom_button.dart';
import 'package:cashly/feautures/auth/presentation/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SvgPicture.asset('assets/svg/photoIntro.svg'),
            SizedBox(height: 40,),

            Container(

                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 32), // Padding Interno del Container

              child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,

                children: [

                  Text(
                      "Bievenido a Cashly",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontFamily: 'Logotype',
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w500,

                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Text(
                      'Tu dinero, tu control. Administra tus finanzas de forma inteligente y segura.',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,

                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                      text: 'Comenzar',
                    style: 'primary',
                    onPressed: (){
                        Navigator.of(context).push(
                          _createRoute(),
                        );

                    },
                  ),

                ]

              ),
            ),
          ],
        ),

      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}