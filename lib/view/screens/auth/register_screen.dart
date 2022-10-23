import 'package:animate_do/animate_do.dart';
import 'package:atharna/controller/auth_provider.dart';
import 'package:atharna/controller/utils/firebase.dart';
import 'package:atharna/model/models.dart';
import 'package:atharna/model/sizer.dart';
import 'package:atharna/view/resources/color_manager.dart';
import 'package:atharna/view/resources/style_manager.dart';
import 'package:atharna/view/resources/values_manager.dart';
import 'package:atharna/widgets/button_widget.dart';
import 'package:atharna/widgets/constants.dart';
import 'package:atharna/widgets/textfeild_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../../model/const.dart';
import 'verification_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();
  bool _isLoading = false;
  late AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: whit,
          elevation: 0,
          iconTheme: IconThemeData(
            color: color1,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(
                    child: Text(
                      'Creat Account',
                      style: getBoldStyle(color: ColorManager.black,fontSize: Sizer.getW(context)/12),
                    ),
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 50),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Text(
                        'SignUp to get started..',
                        style: getRegularStyle(color: ColorManager.lightGray,fontSize: Sizer.getW(context) / 26),
                        
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 100),
                    child: Text(
                      'Name',
                      
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 150),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        hintText: 'Enter first and last name',
                        hintStyle: TextStyle(
                          color: color1,
                          fontSize: 14.0,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
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
                    height: 10,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 200),
                    child: Text(
                      'Email',
                      
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 250),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
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
                    height: 10,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 300),
                    child: Text(
                      'Phone',
                     
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 350),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade200, width: 1.7),
                      ),
                      child: Stack(
                        children: [
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                            },
                            onInputValidated: (bool value) {
                              print(value);
                            },
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            selectorTextStyle: TextStyle(color: color1),
                            textFieldController: phoneController,
                            formatInput: false,
                            maxLength: 9,
                            keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                            cursorColor: Colors.black,
                            inputDecoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 15, left: 0),
                              border: InputBorder.none,
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                color: color1,
                                fontSize: 14.0,
                              ),
                            ),
                            onSaved: (PhoneNumber number) {
                              print('On Saved: $number');
                            },
                          ),
                          Positioned(
                            left: Sizer.getW(context) / 4.5,
                            top: AppSize.s8,
                            bottom: AppSize.s8,
                            child: Container(
                              height: 30,
                              width: 1,
                              color: Colors.black.withOpacity(0.13),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 400),
                    child: Text(
                      'Password',
                      
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 450),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: color1,
                          fontSize: 14.0,
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
                          color: blak,
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
                    height: 10,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 500),
                    child: Text(
                      'Confirm Password',
                     
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 550),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: passwordConfirmationController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: color1,
                          fontSize: 14.0,
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
                  SizedBox(
                    height: 30,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 600),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: color1,
                        onPrimary: whit,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        performRegister();
                      },
                      child: _isLoading
                          ? Container(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                backgroundColor: whit,
                                color: blak,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              "Register",
                              style: TextStyle(color: whit),
                            ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 700),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(color: color1),
                        ),
                        TextButton(onPressed: (){
                            Navigator.of(context).pushReplacementNamed('/login_screen');
                        }, child: Text('Login'))
                       
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (nameController.text.isNotEmpty && emailController.text.isNotEmpty && phoneController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      return true;
    }
    Const.showSnackBar(
      context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }

  Future<void> register() async {
    setState(() {
      _isLoading = true;
    });
    authProvider.name = nameController;
    authProvider.email =emailController;
    authProvider.phoneNumber = phoneController;
    authProvider.password = passwordController;
    authProvider.confirmPassword = passwordConfirmationController;
    Const.LOADIG(context);
   var result =await authProvider.signup(context);
    Navigator.pop(context);
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        _isLoading = false;
      });
      if(result['status'])
     Navigator.push(context, MaterialPageRoute(builder: (context) => VerificatoinScreen()));
    });
  }
}
