import 'package:atharna/widgets/constants.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.textEditingController,
    this.textInputType = TextInputType.text,
    this.cursorColor = Colors.grey,
    this.obscureText = false,
    this.hint = '',
  }) : super(key: key);
  final Color cursorColor;
  final String hint;

  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: cursorColor,
      controller: textEditingController,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 15, left:15),
        
        enabledBorder: border(),
        focusedBorder: border(
          borderColor: blak.withOpacity(0.5),
        ),
      ),
    );
  }

  OutlineInputBorder border({Color borderColor = Colors.grey}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color1.withOpacity(0.2),
        width: 0.3,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}