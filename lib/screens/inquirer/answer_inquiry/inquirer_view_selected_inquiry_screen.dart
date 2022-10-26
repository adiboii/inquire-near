// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:inquire_near/components/inquiry_image.dart';
import 'package:inquire_near/screens/inquirer/answer_inquiry/widgets/inquirer_bottom_bar.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquirerViewSelectedInquiryScreen extends StatefulWidget {
  InquirerViewSelectedInquiryScreen({Key? key}) : super(key: key);
  final answerTextController = TextEditingController();

  @override
  State<InquirerViewSelectedInquiryScreen> createState() =>
      _InquirerViewSelectedInquiryScreenState();
}

class _InquirerViewSelectedInquiryScreenState
    extends State<InquirerViewSelectedInquiryScreen> {
  @override
  Widget build(BuildContext context) {
    File? image;
    // ignore: unused_local_variable
    bool requireProof = false;
    void onIconSelected(File file) {
      setState(() {
        image = file;
      });
    }

    void onCrossIconPressed() {
      setState(() {
        image = null;
      });
    }

    void updateBool(bool value) {
      setState(() {
        requireProof = value;
      });
    }

    // Screen Dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const AutoSizeText(
          'Inquiry 1',
          style: theme.headline,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: theme.kScreenPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: screenHeight * 0.02,
                            backgroundImage: const AssetImage(
                              'assets/images/illustrations/profile.png',
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          const AutoSizeText(
                            'Is it open right now?',
                            style: theme.subhead,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.1,
                      ),
                      Row(
                        verticalDirection: VerticalDirection.up,
                        children: [
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.end,
                              controller: widget.answerTextController,
                              decoration: const InputDecoration(
                                hintText: 'Leave an answer',
                                hintStyle: theme.subhead,
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          CircleAvatar(
                            radius: screenHeight * 0.02,
                            backgroundImage: const AssetImage(
                              'assets/images/illustrations/profile.png',
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 24, 0, 10),
                        child: InquiryImage(
                          image: image,
                          onCrossIconPressed: onCrossIconPressed,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InquirerBottomBar(
              onIconSelected: onIconSelected,
              requireProof: updateBool,
            ),
          ),
        ],
      ),
    );
  }
}
