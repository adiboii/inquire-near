import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  String source;
  IconContainer({required this.source});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 75,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: IconButton(
          onPressed: () {}, color: Colors.grey[200], icon: Image.asset(source)),
    );
  }
}
