import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'values_manager.dart';
class MyTheme {
  static var lightTheme = ThemeData(
    primaryColor: Color(0xffAB6F5A),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xffAB6F5A),
        centerTitle: true,
        elevation: AppSize.s4,
        titleTextStyle: getRegularStyle(
            color: ColorManager.white, fontSize: FontSize.s16)
    ),
    //elvatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: Color(0xffAB6F5A),
          textStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s17),
          minimumSize: Size(double.infinity, AppSize.s60),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s8)
          )
      ),
    ),
    //InputDecoration Theme
    inputDecorationTheme: InputDecorationTheme(
      iconColor: Color(0xffAB6F5A),

      // contentPadding:const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
          color: ColorManager.lightGray, fontSize: FontSize.s14),
      //label
      labelStyle: getMediumStyle(
          color: ColorManager.blackGray, fontSize: FontSize.s14),
      //error
      errorStyle: getRegularStyle(
          color: ColorManager.error, fontSize: FontSize.s14),

      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          borderSide: BorderSide(color: ColorManager.lightGray)
      ),

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          borderSide: BorderSide(color: Color(0xffAB6F5A))
      ),

      errorBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(AppSize.s8)

      ),
      focusedErrorBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(AppSize.s8)
      ),
    ),
    iconTheme: IconThemeData(
      color: Color(0xffAB6F5A),
    )
  );

}

ThemeData getApplicationTheme({bool isDark = false}){
  // return isDark ? MyTheme().darkTheme : MyTheme().lightTheme;
  return isDark ? ThemeData.dark().copyWith(
    inputDecorationTheme: InputDecorationTheme(
      iconColor: ThemeData.dark().iconTheme.color,
      // contentPadding:const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
          color: ColorManager.lightGray, fontSize: FontSize.s14),
      //label
      labelStyle: getMediumStyle(
          color: ColorManager.blackGray, fontSize: FontSize.s14),
      //error
      errorStyle: getRegularStyle(
          color: ColorManager.error, fontSize: FontSize.s14),

      enabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(AppSize.s8)

      ),

      focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(AppSize.s8)

      ),

      errorBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(AppSize.s8)

      ),
      focusedErrorBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(AppSize.s8)
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(

          textStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s17),
          minimumSize: Size(double.infinity, AppSize.s60),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s8)
          )
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ThemeData.dark().primaryColor,
        centerTitle: true,
        elevation: AppSize.s4,
        titleTextStyle: getRegularStyle(
            color: ColorManager.white, fontSize: FontSize.s16)
    ),
  ) : ThemeData.light().copyWith(
    inputDecorationTheme: InputDecorationTheme(
      // contentPadding:const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
          color: ColorManager.lightGray, fontSize: FontSize.s14),
      //label
      labelStyle: getMediumStyle(
          color: ColorManager.blackGray, fontSize: FontSize.s14),
      //error
      errorStyle: getRegularStyle(
          color: ColorManager.error, fontSize: FontSize.s14),

      enabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(AppSize.s8)

      ),

      focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(AppSize.s8)

      ),

      errorBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(AppSize.s8)

      ),
      focusedErrorBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(AppSize.s8)
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: Colors.red,
          textStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s17),
          minimumSize: Size(double.infinity, AppSize.s60),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s8)
          )
      ),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue[300],
        centerTitle: true,
        elevation: AppSize.s4,
        titleTextStyle: getRegularStyle(
            color: ColorManager.white, fontSize: FontSize.s16)
    ),
  );
}