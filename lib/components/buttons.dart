import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ButtonOutline extends StatelessWidget {
  double width;
  double height;
  String label;
  VoidCallback? onTap;
  Color color;
  Color textColor;
  ButtonOutline(
      {this.width = 300,
      this.height = 55,
      required this.label,
      this.onTap,
      this.color = theme.primary,
      this.textColor = theme.primary});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide(color: color),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonFill extends StatelessWidget {
  double width;
  double height;
  String label;
  Color color;
  Color textColor;
  VoidCallback? onTap;
  ButtonFill(
      {this.height = 55,
      this.width = 300,
      required this.label,
      this.onTap,
      this.color = theme.primary,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: TextButton(
          onPressed: onTap,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(color),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
