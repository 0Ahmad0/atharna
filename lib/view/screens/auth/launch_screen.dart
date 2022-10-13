import 'package:animate_do/animate_do.dart';
import 'package:atharna/widgets/constants.dart';
import 'package:flutter/material.dart';

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
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/login_screen');
    });
  }


  @override
  Widget build(BuildContext context) {
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
