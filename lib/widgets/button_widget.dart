import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  String text;
  Color buttonColor;
  Color textColor;
  double width;
  double height;
  Function onPress;

  WidgetButton({
    required this.onPress,
    required this.text,
    this.textColor = Colors.white,
    required this.buttonColor,
    this.width = 200,
    this.height= 50,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        onPrimary: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        minimumSize: Size(width, height),
      ),
      onPressed: () {
        onPress();
      },
      child: Text(
        text,
      ),
    );
  }
}