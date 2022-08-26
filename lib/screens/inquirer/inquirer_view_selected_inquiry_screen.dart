import 'package:auto_size_text/auto_size_text.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:inquire_near/components/BottomBar.dart';
import 'package:inquire_near/components/InquiryImage.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquirerViewSelectedInquiryScreen extends StatefulWidget {
  const InquirerViewSelectedInquiryScreen({Key? key}) : super(key: key);

  @override
  State<InquirerViewSelectedInquiryScreen> createState() =>
      _InquirerViewSelectedInquiryScreenState();
}

class _InquirerViewSelectedInquiryScreenState
    extends State<InquirerViewSelectedInquiryScreen> {
  @override
  Widget build(BuildContext context) {
    File? _image;
    void _onIconSelected(File file) {
      setState(() {
        _image = file;
      });
    }

    void _onCrossIconPressed() {
      setState(() {
        _image = null;
      });
    }

    // Screen Dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
        title: AutoSizeText(
          'Inquiry 1',
          style: theme.headline,
        ),
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
                        children: const [
                          BackButton(),
                          AutoSizeText(
                            'Inquiry 1',
                            style: theme.headline,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: screenHeight * 0.02,
                            backgroundImage: AssetImage(
                              'assets/images/illustrations/profile.png',
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          AutoSizeText(
                            'Is it open right now?',
                            style: theme.subhead,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.1,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: screenHeight * 0.02,
                            backgroundImage: AssetImage(
                              'assets/images/illustrations/profile.png',
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          AutoSizeText(
                            'Yes',
                            style: theme.subhead,
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
                ],
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
