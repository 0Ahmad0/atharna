
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../view/resources/color_manager.dart';
import '../view/resources/style_manager.dart';
import '../view/resources/values_manager.dart';
import '../view/widgets/custome_button.dart';
import 'sizer.dart';
import 'package:get/get.dart';

class Const{

  static LOADIG(context){
    Get.dialog(
        Center(
          child: Container(
              alignment: Alignment.center,
              width: Sizer.getW(context) * 0.2,
              height: Sizer.getW(context) * 0.2,
              decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppSize.s8)),
              child: LoadingAnimationWidget.waveDots(
                  color: ColorManager.primary,
                  size: Sizer.getW(context) * 0.1)),
        ),
        barrierDismissible: false
    );
  }

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