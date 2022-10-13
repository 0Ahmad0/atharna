
import 'package:atharna/controller/home_provider.dart';
import 'package:atharna/controller/nav_bar_provider.dart';
import 'package:atharna/view/screens/add_ruins/add_ruin_screen.dart';
import 'package:atharna/view/screens/favorite/favorite_screen.dart';
import 'package:atharna/view/screens/home/home_screen.dart';
import 'package:atharna/view/screens/nav_bar/nav_bar_screen.dart';
import 'package:atharna/view/screens/profile/profile_screen.dart';
import 'package:atharna/view/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/resources/theme_manager.dart';
import 'view/screens/auth/launch_screen.dart';
import 'view/screens/auth/login_screen.dart';
import 'view/screens/auth/onboarding_screen.dart';
import 'view/screens/auth/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>NavBarProvider()),
      Provider<HomeProvider>(create: (_)=>HomeProvider()),

    ],
    child:  MaterialApp(
     theme: MyTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen': (context) => const LaunchScreen(),
            '/on_boarding_screen': (context) => const  OnBoardingScreen(),
            '/login_screen': (context) => const  LoginScreen(),
            '/register_screen': (context) => const RegisterScreen(),
            '/nav_bar_screen': (context) => const NavBarScreen(),
            '/home_screen': (context) =>  HomeScreen(),
            '/search_screen': (context) =>  SearchScreen(),
            '/add_ruin_screen': (context) => const AddRuinScreen(),
            '/favorite_screen': (context) => const FavoriteScreen(),
            '/profile_screen': (context) => const ProfileScreen(),

          },
        )
    );
    }
}


