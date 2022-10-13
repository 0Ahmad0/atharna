
import 'package:atharna/screens/auth/launch_screen.dart';
import 'package:atharna/screens/auth/login_screen.dart';
import 'package:atharna/screens/auth/onboarding_screen.dart';
import 'package:atharna/screens/auth/register_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen': (context) => const LaunchScreen(),
            '/on_boarding_screen': (context) => const  OnBoardingScreen(),
            '/login_screen': (context) => const  LoginScreen(),
            '/register_screen': (context) => const RegisterScreen(),

          },
        );
  }
}


