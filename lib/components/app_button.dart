import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String name;
  final Function onChanged;
  final Color backgroundColor;
  final Color primaryColor;
  final Color onSurfaceColor;
  final Color textColor;
  const AppButton({
    required this.name,
    required this.onChanged,
    required this.backgroundColor,
    required this.primaryColor,
    required this.onSurfaceColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onChanged(),
      style: TextButton.styleFrom(
        elevation: 8,
        primary: primaryColor,
        onSurface: onSurfaceColor,
        backgroundColor: backgroundColor,
        padding: EdgeInsets.all(10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        fixedSize: Size(
          MediaQuery.of(context).size.width * 0.5,
          60,
        ),
      ),
      child: Text(
        name.toUpperCase(),
        style: TextStyle(
            color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
