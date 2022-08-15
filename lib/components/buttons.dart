import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ButtonOutline extends StatelessWidget {
  double width;
  double height;
  String label;
  Color color;
  Color textColor;
  double fontSize;
  double borderRadius;
  VoidCallback? onTap;
  TextStyle style;
  ButtonOutline(
      {this.width = double.infinity,
      this.height = 55,
      required this.label,
      this.onTap,
      this.color = theme.primary,
      this.textColor = theme.primary,
      this.fontSize = 14,
      this.borderRadius = 10,
      this.style = theme.headline});

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
                borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          ),
          child: Text(
            label,
            style: style.copyWith(color: textColor),
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
  double fontSize;
  double borderRadius;
  VoidCallback? onTap;
  TextStyle style;
  ButtonFill(
      {this.height = 55,
      this.width = double.infinity,
      required this.label,
      this.onTap,
      this.color = theme.primary,
      this.textColor = Colors.white,
      this.fontSize = 14,
      this.borderRadius = 10,
      this.style = theme.headline});

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
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(color),
          ),
          child: Text(label, style: style.copyWith(color: textColor)),
        ),
      ),
    );
  }
}
