// Dart imports:
import 'dart:developer';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';

// Project imports:
import 'package:inquire_near/components/bottom_bar.dart';
import 'package:inquire_near/components/inquiry_image.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/screens/client/Add_Inquiry_Screen/widgets/add_inquiry_input.dart';
import 'package:inquire_near/screens/client/Add_Inquiry_Screen/widgets/add_title_bar.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class AddInquiryScreen extends StatefulWidget {
  const AddInquiryScreen({super.key});

  @override
  State<AddInquiryScreen> createState() => _AddInquiryScreenState();
}

class _AddInquiryScreenState extends State<AddInquiryScreen> {
  @override
  File? image;
  late Inquiry inquiry;
  bool requireProof = false;
  TextEditingController inquiryContoller = TextEditingController();

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

  void saveInquiryThenPop() {}

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
                            onTap: () {
                              setState(() {
                                inquiry = Inquiry(
                                    inquiryListID:
                                        BlocProvider.of<InquiryBloc>(context)
                                            .inquiryList
                                            .getID(),
                                    question: inquiryContoller.text,
                                    requiresProof: requireProof,
                                    image: image);
                              });

                              BlocProvider.of<InquiryBloc>(context)
                                  .add(AddInquiryRequested(inquiry: inquiry));

                              Navigator.pop(context);
                            },
                          ),
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
