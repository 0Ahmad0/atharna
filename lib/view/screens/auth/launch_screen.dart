import 'package:animate_do/animate_do.dart';
import 'package:atharna/controller/auth_provider.dart';
import 'package:atharna/view/screens/auth/login_screen.dart';
import 'package:atharna/view/screens/auth/onboarding_screen.dart';
import 'package:atharna/view/screens/home/home_screen.dart';
import 'package:atharna/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/profile_provider.dart';
import '../../../model/models.dart';
import '../../../model/utils/local/storage.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      ///Navigator.pushReplacementNamed(context, '/login_screen');
    });
  }

  init(context,authProvider,profileProvider) async {
    await AppStorage.init();
    //print("f ${Advance.uid}");
    if(Advance.isLogined&&Advance.token!=""){
      final result = await authProvider.fetchUser(uid: Advance.uid);
      if(result['status']){
        profileProvider.updateUser(user:User.fromJson(result['body']));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (ctx) => HomeScreen()));
      }else{
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (ctx) => LoginScreen()));
      }

    }else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnBoardingScreen()
            //HomeView()
            // LoginView()
          ));
    }
  }
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    init(context,authProvider,profileProvider);
    return Scaffold(
      backgroundColor: whit,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/splash.png'),
            SizedBox(height: 10,),
            Text(
              'Atharna',
            ),
          ],
        ),
      ),
    );
  }
}
