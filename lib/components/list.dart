import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

class AvailableInquirer extends StatelessWidget {
  final String name;
  final String rating;
  final String location;
  const AvailableInquirer({
    required this.name,
    required this.rating,
    required this.location,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue[800],
          radius: 30,
        ),
        SizedBox(width: 24),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: theme.subhead_bold,
            ),
            SizedBox(height: 4),
            Row(
              children: [
                SvgPicture.asset("assets/images/svgs/star.svg"),
                Text(
                  rating,
                  style: theme.caption2,
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                SvgPicture.asset("assets/images/svgs/location.svg"),
                Text(
                  location,
                  style: theme.caption2,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
