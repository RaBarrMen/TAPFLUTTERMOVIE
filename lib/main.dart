
import 'package:flutter/material.dart';
import 'package:flutter_rbm/screens/dashboard_screen.dart';
import 'package:flutter_rbm/screens/popular_screen.dart';
import 'package:flutter_rbm/screens/splash_screen.dart';
import 'package:flutter_rbm/settings/global_values.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.bandera_theme_dark,
      builder: (context,value,_) {
        return MaterialApp(
          theme: value ? ThemeData.dark() : ThemeData.light(),
          title: 'Material App',
          routes: {
            "/dash" : (context) => const DashboardScreen(),
            "/movies" : (context) => const PopularScreen()
          },
          home: const SplashScreen()
        );
      }
    );
  }
}