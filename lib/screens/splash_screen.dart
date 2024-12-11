import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rbm/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/zelda_button_logo.jpg'),
      logoWidth: 100,
      title: const Text('Bienvenidos', style: TextStyle(fontSize: 20),),
      showLoader: true,
      loadingText: const Text('Cargando...'),
      navigator: const LoginScreen(),
      durationInSeconds: 4,
      gradientBackground: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Colors.red
        ]
      ),
    );
  }
}