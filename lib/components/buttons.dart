import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ButtonOutline extends StatefulWidget {
  final double width;
  final double height;
  final String label;
  final Color color;
  final Color textColor;
  final double fontSize;
  final double borderRadius;
  final VoidCallback? onTap;
  final TextStyle style;
  const ButtonOutline(
      {super.key,
      this.width = double.infinity,
      this.height = 55,
      required this.label,
      this.onTap,
      this.color = theme.primary,
      this.textColor = theme.primary,
      this.fontSize = 14,
      this.borderRadius = 10,
      this.style = theme.headline});

  @override
  State<ButtonOutline> createState() => _ButtonOutlineState();
}

class _ButtonOutlineState extends State<ButtonOutline> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: OutlinedButton(
          onPressed: widget.onTap,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide(color: widget.color),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius))),
          ),
          child: Text(
            widget.label,
            style: widget.style.copyWith(color: widget.textColor),
          ),
        ),
      ),
    );
  }
}

class ButtonFill extends StatefulWidget {
  final double width;
  final double height;
  final String label;
  final Color color;
  final Color textColor;
  final double fontSize;
  final double borderRadius;
  final VoidCallback? onTap;
  final TextStyle style;
  const ButtonFill(
      {super.key,
      this.height = 55,
      this.width = double.infinity,
      required this.label,
      this.onTap,
      this.color = theme.primary,
      this.textColor = Colors.white,
      this.fontSize = 14,
      this.borderRadius = 10,
      this.style = theme.headline});

  @override
  State<ButtonFill> createState() => _ButtonFillState();
}

class _ButtonFillState extends State<ButtonFill> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: TextButton(
          onPressed: widget.onTap,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(widget.color),
          ),
          child: Text(widget.label,
              style: widget.style.copyWith(color: widget.textColor)),
        ),
      ),
    );
  }
}
