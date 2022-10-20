// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/components/bottom_bar.dart';
import 'package:inquire_near/components/inquiry_image.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/screens/client/Edit_Inquiry_Screen/widgets/edit_inquiry_input.dart';
import 'package:inquire_near/screens/client/Edit_Inquiry_Screen/widgets/edit_title_bar.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class EditInquiryScreen extends StatefulWidget {
  final int index;
  const EditInquiryScreen({super.key, required this.index});

  @override
  State<EditInquiryScreen> createState() => _EditInquiryScreenState();
}

class _EditInquiryScreenState extends State<EditInquiryScreen> {
  TextEditingController inquiryController = TextEditingController();
  late bool requireProof;
  File? image;
  late Inquiry inquiry;

  void _onCrossIconPressed() {
    setState(() {
      inquiry.image = null;
    });
  }

  void _onIconSelected(File file) {
    setState(() {
      inquiry.image = file;
    });
  }

  void updateBool(bool value) {
    setState(() {
      inquiry.requireProof = value;
    });
  }

  void updateMessage(String message) {
    inquiry.question = message;
    inquiryController.selection =
        TextSelection.collapsed(offset: message.length);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      inquiry = BlocProvider.of<InquiryBloc>(context)
          .inquiries
          .elementAt(widget.index);
    });

    requireProof = inquiry.requireProof;
    inquiryController.text = inquiry.question;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    inquiryController.text = inquiry.question.toString();
    requireProof = inquiry.requireProof;
    image = inquiry.image;
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
                          EditInquiryTitleBar(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                            onTap: () {
                              setState(() {
                                inquiry = Inquiry(
                                    inquiryListID:
                                        BlocProvider.of<InquiryBloc>(context)
                                            .inquiryList
                                            .uid!,
                                    question: inquiryController.text,
                                    requireProof: requireProof,
                                    image: image);
                              });

                              BlocProvider.of<InquiryBloc>(context).add(
                                  EditInquiryRequested(
                                      index: widget.index,
                                      editedInquiry: inquiry));

                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          InquiryInput(
                            screenWidth: screenWidth,
                            inquiryContoller: inquiryController,
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
