import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/cards.dart';
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
            AddInquiryCard(
              screenHeight: _height,
              screenWidth: _width,
              onTap: () {
                Navigator.pushNamed(context, '/add_inquiry');
              },
            ),
          ],
        ),
      ),
    );
  }
}
