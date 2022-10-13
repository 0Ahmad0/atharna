
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../view/resources/color_manager.dart';
import '../view/resources/style_manager.dart';
import '../view/resources/values_manager.dart';
import '../view/widgets/custome_button.dart';
import 'sizer.dart';

class Const{
 static void showSnackBar(BuildContext context,
      {required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  

  static TOAST(BuildContext context,{String textToast = "This Is Toast"}){
    showToast(
        textToast,
      context: context,
    animation:StyledToastAnimation.fadeScale,
      textStyle: getRegularStyle(color: ColorManager.white)
    );

  }


    static SHOWLOADINGINDECATOR(){
      return Center(
        child: CircularProgressIndicator(
        ),
      );
    }

}