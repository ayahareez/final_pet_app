

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:frist_project/presentation/pages/form_page.dart';
import 'package:frist_project/presentation/pages/page_controller.dart';

// class SplashScreen extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(
//         duration: 3000,
//         splash: Icons.home,
//         nextScreen: FormPage(),
//         splashTransition: SplashTransition.fadeTransition,
//         backgroundColor: Colors.blue);
//   }
// }

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Icon(Icons.home)],),
    );
  }
}
