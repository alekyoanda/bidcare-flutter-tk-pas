import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    Key? key,
    this.backgroundColor,
    this.size,
    required this.text,
    required this.onPressed,
    this.foregroundColor,
  }) : super(key: key);
  final isDisabled = false;
  final Size? size;
  final Text text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: ElevatedButton.styleFrom(
        fixedSize: (size != null) ? size : Size(340, 50),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        textStyle: const TextStyle(
            fontSize: 16, letterSpacing: 1, fontWeight: FontWeight.w500),
      ),
      onPressed: onPressed,
      child: text,
    );
  }
}
