import 'package:flutter/material.dart';

class DefaultElevatedButtom extends StatelessWidget {
  String label;
  VoidCallback onPressed;
  Color? backgroundColor;
  Color? textColor;

  DefaultElevatedButtom({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.sizeOf(context).width, 48),
      ),
      child: Text(label),
    );
  }
}
