import 'package:atharna/widgets/button_widget.dart';
import 'package:atharna/widgets/constants.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whit,
      body: Column(
        children: [
          Image.asset(
            'assets/onboardheader.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'Become \na part of our cultural \npreservation movement',
          
          ),
          Expanded(
            child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 25,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: color1,
                      onPrimary: whit,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: Size(111, 40),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register_screen');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Next ',
                        
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 21,
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
