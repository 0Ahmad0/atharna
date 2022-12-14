
import 'package:atharna/controller/add_ruin_provider.dart';
import 'package:atharna/controller/auth_provider.dart';
import 'package:atharna/controller/heritage_provider.dart';
import 'package:atharna/controller/home_provider.dart';
import 'package:atharna/controller/nav_bar_provider.dart';
import 'package:atharna/model/models.dart';
import 'package:atharna/view/screens/add_ruins/add_ruin_screen.dart';
import 'package:atharna/view/screens/favorite/favorite_screen.dart';
import 'package:atharna/view/screens/home/home_screen.dart';
import 'package:atharna/view/screens/nav_bar/nav_bar_screen.dart';
import 'package:atharna/view/screens/profile/profile_screen.dart';
import 'package:atharna/view/screens/search/search_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/profile_provider.dart';
import 'view/resources/theme_manager.dart';
import 'view/screens/auth/launch_screen.dart';
import 'view/screens/auth/login_screen.dart';
import 'view/screens/auth/onboarding_screen.dart';
import 'view/screens/auth/register_screen.dart';
import 'package:get/get.dart';
Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  //await CustomGalleryPermissions.requestPermissionExtend();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>NavBarProvider()),
      Provider<HomeProvider>(create: (_)=>HomeProvider()),
      ListenableProvider<AddRuinProvider>(create: (_)=>AddRuinProvider()),
      ListenableProvider<AuthProvider>(create: (_) => AuthProvider()),
      ListenableProvider<ProfileProvider>(create: (_)=>ProfileProvider()),
      ListenableProvider<HeritageProvider>(create: (_)=>HeritageProvider()),

    ],
    child:  GetMaterialApp(
     theme: MyTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen': (context) => const LaunchScreen(),
            '/on_boarding_screen': (context) =>   OnBoardingScreen(),
            '/login_screen': (context) => const  LoginScreen(),
            '/register_screen': (context) => const RegisterScreen(),
            '/nav_bar_screen': (context) => const NavBarScreen(),
            '/home_screen': (context) =>  HomeScreen(),
            '/search_screen': (context) =>  SearchScreen(),
            '/add_ruin_screen': (context) =>  AddRuinScreen(),
            '/favorite_screen': (context) => const FavoriteScreen(),
            '/profile_screen': (context) =>  ProfileScreen(),

          },
        )
    );
    }
}


