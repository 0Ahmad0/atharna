import 'dart:math';

import 'package:flutter/material.dart';

import '../../view/resources/values_manager.dart';

class WidgetProfilePicture extends StatelessWidget {
  Color textColor;
  final String name;
  final String? role;
  final double radius;
  final double fontSize;
  WidgetProfilePicture({
    this.textColor = Colors.white,
     required this.name,
    this.role,
     required this.radius,
     required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.brown,
      child:
          Text(
            '${findFirstsCharFromText(name)}',
            style: TextStyle(
              fontSize: fontSize,
              color: textColor
            ),),
    );
  }
  String findFirstsCharFromText(String text){
    String firstsCharFromText="";
    List<String> listFromWord=text.split(" ");
    firstsCharFromText+=listFromWord.first[0].toUpperCase();
    (listFromWord.length>1)?firstsCharFromText+=listFromWord.last[0]:"";
    return firstsCharFromText;
  }
}