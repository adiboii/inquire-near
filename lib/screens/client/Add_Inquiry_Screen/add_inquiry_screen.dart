// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/components/bottom_bar.dart';
import 'package:inquire_near/components/inquiry_image.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/screens/client/Add_Inquiry_Screen/widgets/add_inquiry_input.dart';
import 'package:inquire_near/screens/client/Add_Inquiry_Screen/widgets/add_title_bar.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class AddInquiryScreen extends StatefulWidget {
  const AddInquiryScreen({Key? key}) : super(key: key);

  @override
  State<AddInquiryScreen> createState() => _AddInquiryScreenState();
}

class _AddInquiryScreenState extends State<AddInquiryScreen> {
  late Inquiry inquiry;
  TextEditingController inquiryContoller = TextEditingController();
  bool requireProof = false;
  File? image;

  void _onCrossIconPressed() {
    setState(() {
      image = null;
    });
  }

  void _onIconSelected(File file) {
    setState(() {
      image = file;
    });
  }

  void updateBool(bool value) {
    setState(() {
      requireProof = value;
    });
  }

  void saveInquiryThenPop() {
    inquiry = Inquiry(
        question: inquiryContoller.text,
        requiresProof: requireProof,
        image: image);

    Navigator.pop(context, inquiry);
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
                          AddInquiryTitleBar(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              onTap: saveInquiryThenPop),
                          SizedBox(height: screenHeight * 0.04),
                          AddInquiryInput(
                              screenWidth: screenWidth,
                              inquiryContoller: inquiryContoller),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 24, 0, 10),
                        child: InquiryImage(
                          image: image,
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
              initialValue: requireProof,
              requireProof: updateBool,
            ),
          ),
        ],
      ),
    );
  }
}
