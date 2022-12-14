import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:atharna/controller/heritage_provider.dart';
import 'package:atharna/controller/utils/create_environment_provider.dart';
import 'package:atharna/controller/utils/firebase.dart';
import 'package:atharna/model/sizer.dart';
import 'package:atharna/view/resources/color_manager.dart';
import 'package:atharna/view/resources/style_manager.dart';
import 'package:atharna/widgets/button_widget.dart';
import 'package:atharna/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/auth_provider.dart';
import '../../../model/const.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  // final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  late AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    bool _isObscure = true;
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  FadeInDown(
                    child: Text(
                      'Login',
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: Sizer.getW(context) / 12
                      ),
                    ),
                  ),
                  FadeInDown(
                    delay:const Duration(milliseconds: 100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Text(
                        'Welcome Again ..',
                        style: getRegularStyle(color: ColorManager.lightGray,fontSize: Sizer.getW(context) / 26),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 150),
                    child: Text(
                      'Email Address',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 200),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: 'Enter your email here',
                        hintStyle: TextStyle(
                          color: color1,
                          fontSize: 14.0,
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: color1,
                          size: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54, width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 250),
                    child: Text(
                      'Password',

                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 300),
                    child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: _isObscure,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: color1,
                          fontSize: 14.0,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure ? Icons.visibility : Icons.visibility_off,
                            color: color1,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: color1,
                          size: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54, width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 350),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  FadeInDown(
                    delay: Duration(milliseconds: 400),
                    child: Center(
                      child:
                      WidgetButton(
                        buttonColor: color1,
                        width: MediaQuery.of(context).size.width,
                        text:_isLoading?
                            '${FirebaseFun.findTextToast("Loading ..")}':
                        'Login',
                        onPress: () async {
                          !_isLoading?
                          (await performLogin(context)):"";
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                      ),
                    ),
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 450),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(color: color1, fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register_screen');
                          },
                          child: Text(
                            'Register',
                          ),
                        )
                      ],
                    ),
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 400),
                    child: Center(
                      child:
                      WidgetButton(
                        buttonColor: color1,
                        width: MediaQuery.of(context).size.width,
                        text: 'done',
                        onPress: () async {
                          Const.LOADIG(context);
                         /// await CreateEnvironmentProvider().createAdmins(context);
                          await CreateEnvironmentProvider().createHeritages(context);
                          ///await HeritageProvider().fetchHeritages();
                         /// await HeritageProvider().fetchHeritageTypes();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> performLogin(context) async {
    if (checkData()) {
      await login(context);
    }
  }

  bool checkData() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      return true;
    }
    Const.showSnackBar(
      context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }

  Future<void> login(context) async {
    setState(() {
      _isLoading = true;
    });
    authProvider.email =emailController;
    authProvider.password = passwordController;
    Const.LOADIG(context);
   final result =await authProvider.login(context);
    Navigator.pop(context);
    setState(() {
      _isLoading = false;
    });
    if(result['status']){
      Navigator.pushReplacementNamed(context, '/nav_bar_screen');
    }

  }
}
