import 'package:bidcare/styles/colors.dart';
import 'package:flutter/material.dart';

class MyTextIconButton extends StatelessWidget {
  const MyTextIconButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.color,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final Icon icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: MyColor.green1,
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 8),
            child: icon,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: (color != null) ? color : MyColor.darkGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}