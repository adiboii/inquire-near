// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:inquire_near/components/bottom_bar.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/inquiry_image.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class AddInquiryScreen extends StatefulWidget {
  const AddInquiryScreen({Key? key}) : super(key: key);

  @override
  State<AddInquiryScreen> createState() => _AddInquiryScreenState();
}

class _AddInquiryScreenState extends State<AddInquiryScreen> {
  File? _image;

  void _onCrossIconPressed() {
    setState(() {
      _image = null;
    });
  }

  void _onIconSelected(File file) {
    setState(() {
      _image = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: theme.kScreenPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //TODO: change to icon
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SvgPicture.asset(
                                        "assets/images/svgs/cancel.svg"),
                                  ),
                                  SizedBox(width: screenWidth * 0.04),
                                  SvgPicture.asset(
                                      "assets/images/svgs/add_inquiry.svg"),
                                  SizedBox(width: screenWidth * 0.04),
                                  const Text(
                                    "Add an inquiry",
                                    style: theme.headline,
                                  ),
                                ],
                              ),

                              ButtonFill(
                                label: "Add inquiry",
                                width: screenWidth * 0.25,
                                height: screenHeight * 0.05,
                                style: theme.caption1Bold,
                                borderRadius: 5,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/available_inquirers');
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: CircleAvatar(
                                  radius: screenWidth * 0.05,
                                  backgroundImage: const AssetImage(
                                    'assets/images/illustrations/profile.png',
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              SizedBox(
                                width: screenWidth * 0.7,
                                child: const TextField(
                                  decoration: InputDecoration.collapsed(
                                      hintText: "What do you need?"),
                                  style: theme.subhead,
                                  maxLength: 150,
                                  maxLines: null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 24, 0, 10),
                        child: InquiryImage(
                          image: _image,
                          onCrossIconPressed: _onCrossIconPressed,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomBar(
              onIconSelected: _onIconSelected,
            ),
          ),
        ],
      ),
    );
  }
}
