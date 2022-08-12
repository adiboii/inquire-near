import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryListScreen extends StatefulWidget {
  InquiryListScreen({Key? key}) : super(key: key);

  @override
  State<InquiryListScreen> createState() => _InquiryListScreenState();
}

class _InquiryListScreenState extends State<InquiryListScreen> {
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: Row(
          children: [
            Image(
              image: AssetImage('assets/images/logos/BIR.png'),
              width: 45,
              height: 45,
            ),
            SizedBox(width: 12),
            Text(
              "Bureau of Internal Revenue\nCebu South Branch",
              style: theme.headline,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What do you need from here?",
              style: theme.headline.copyWith(fontSize: 16),
            ),
            SizedBox(height: 12),
            SizedBox(
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
                          SvgPicture.asset(
                              "assets/images/svgs/add_inquiry.svg"),
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
            ),
          ],
        ),
      ),
    );
  }
}
