import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

import 'buttons.dart';

class AddInquiryCard extends StatelessWidget {
  const AddInquiryCard({
    Key? key,
    required double height,
    required double width,
  })  : _height = height,
        _width = width,
        super(key: key);

  final double _height;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height * 0.25,
      width: _width * 0.90,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.lightBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/images/svgs/add_inquiry.svg"),
                  SizedBox(width: 10),
                  Text(
                    "Start by adding an inquiry",
                    style: theme.headline,
                  ),
                ],
              ),
              Text(
                "Make sure to be specific and only ask questions that can be answered",
                style: theme.caption1,
              ),
              ButtonFill(label: "Add an inquiry"),
            ],
          ),
        ),
      ),
    );
  }
}
