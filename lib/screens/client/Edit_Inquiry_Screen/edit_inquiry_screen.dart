// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/components/bottom_bar.dart';
import 'package:inquire_near/components/inquiry_image.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/screens/client/Edit_Inquiry_Screen/widgets/edit_inquiry_input.dart';
import 'package:inquire_near/screens/client/Edit_Inquiry_Screen/widgets/edit_title_bar.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class EditInquiryScreen extends StatefulWidget {
  final Inquiry inquiry;
  const EditInquiryScreen({super.key, required this.inquiry});

  @override
  State<EditInquiryScreen> createState() => _EditInquiryScreenState();
}

class _EditInquiryScreenState extends State<EditInquiryScreen> {
  TextEditingController inquiryContoller = TextEditingController();
  late bool requireProof;
  File? image;
  void _onCrossIconPressed() {
    setState(() {
      widget.inquiry.image = null;
    });
  }

  void _onIconSelected(File file) {
    setState(() {
      widget.inquiry.image = file;
    });
  }

  void updateBool(bool value) {
    setState(() {
      widget.inquiry.requiresProof = value;
    });
  }

  void updateMessage(String message) {
    widget.inquiry.question = message;
    inquiryContoller.selection =
        TextSelection.collapsed(offset: message.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requireProof = widget.inquiry.requiresProof;
    inquiryContoller.text = widget.inquiry.question;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    inquiryContoller.text = widget.inquiry.question.toString();
    requireProof = widget.inquiry.requiresProof;
    image = widget.inquiry.image;
    //Inquiry inquiry;
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
                          TitleBar(
                            inquiry: widget.inquiry,
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                            inquiryContoller: inquiryContoller,
                            requireProof: requireProof,
                            image: image,
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          InquiryInput(
                            screenWidth: screenWidth,
                            inquiryContoller: inquiryContoller,
                            updateMessage: updateMessage,
                          ),
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
