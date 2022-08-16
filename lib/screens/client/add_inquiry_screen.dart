import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inquire_near/components/InquiryImage.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:inquire_near/components/BottomBar.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class AddInquiryScreen extends StatefulWidget {
  AddInquiryScreen({Key? key}) : super(key: key);

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
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: height,
              width: width,
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
                                  SizedBox(width: 12),
                                  SvgPicture.asset(
                                      "assets/images/svgs/add_inquiry.svg"),
                                  SizedBox(width: 12),
                                  Text(
                                    "Add an inquiry",
                                    style: theme.headline,
                                  ),
                                ],
                              ),

                              ButtonFill(
                                label: "Add inquiry",
                                width: width * 0.25,
                                height: height * 0.05,
                                style: theme.caption1_bold,
                                borderRadius: 5,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/finding_inquirer');
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: CircleAvatar(
                                  radius: width * 0.05,
                                  backgroundImage: AssetImage(
                                    'assets/images/illustrations/profile.png',
                                  ),
                                ),
                              ),
                              SizedBox(width: 24),
                              SizedBox(
                                width: width * 0.7,
                                child: TextField(
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
