import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InListItem extends StatelessWidget {
  Color color;
  String type;
  String amount;

  InListItem({required this.color, required this.type, required this.amount});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: theme.gray,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 5,
              ),
              SizedBox(width: 10),
              Text(type),
            ],
          ),
          Text(amount),
        ],
      ),
    );
  }
}
