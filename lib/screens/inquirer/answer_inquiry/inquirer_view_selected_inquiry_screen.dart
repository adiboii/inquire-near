// Dart imports:
import 'dart:developer';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/components/inquiry_image.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';
import 'package:inquire_near/screens/client/Edit_Inquiry_Screen/widgets/edit_title_bar.dart';
import 'package:inquire_near/screens/inquirer/answer_inquiry/widgets/inquirer_bottom_bar.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquirerViewSelectedInquiryScreen extends StatefulWidget {
  InquirerViewSelectedInquiryScreen({
    Key? key,
    this.inquiryIndex = 1,
  }) : super(key: key);
  final answerTextController = TextEditingController();
  final int inquiryIndex;

  @override
  State<InquirerViewSelectedInquiryScreen> createState() =>
      _InquirerViewSelectedInquiryScreenState();
}

class _InquirerViewSelectedInquiryScreenState
    extends State<InquirerViewSelectedInquiryScreen> {
  Inquiry? inquiry;
  File? image;

  @override
  void initState() {
    super.initState();
    inquiry = BlocProvider.of<InquiryBloc>(context)
        .inquiries[widget.inquiryIndex - 1];
    if (inquiry!.answerMessage != null) {
      widget.answerTextController.text = inquiry!.answerMessage!;
      if (inquiry!.answerImage != null) {
        image = inquiry!.answerImage;
      }
    }
  }

  void _answerInquiry(context) {
    setState(() {
      inquiry!.answer = widget.answerTextController.text;
    });
    if (image != null) {
      inquiry!.answerImg = image!;
    } else {
      inquiry!.answerImg = null;
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: theme.kScreenPadding,
              child: Column(
                children: [
                  InquiryTitleBar(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    onTap: () {
                      _answerInquiry(context);
                    },
                    label: 'Inquiry ${widget.inquiryIndex}',
                    buttonLabel: 'Submit',
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
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
                              AutoSizeText(
                                inquiry!.question,
                                style: theme.subhead,
                              ),
                            ],
                          ),
                          (inquiry!.imageUrl != null)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 24, 0, 10),
                                  child: InquiryImage(
                                    imageUrl: inquiry!.imageUrl,
                                  ),
                                )
                              : const SizedBox(),
                          AnswerContainer(
                            widget: widget,
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 24, 0, 10),
                            child: InquiryImage(
                              image: image,
                              onCrossIconPressed: onCrossIconPressed,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.1,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InquirerBottomBar(
              onIconSelected: onIconSelected,
              requireProof: inquiry!.requireProof,
            ),
          ),
        ],
      ),
    );
  }
}

class AnswerContainer extends StatelessWidget {
  const AnswerContainer({
    Key? key,
    required this.widget,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  final InquirerViewSelectedInquiryScreen widget;
  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      verticalDirection: VerticalDirection.up,
      children: [
        Expanded(
          child: TextField(
            textAlign: TextAlign.end,
            controller: widget.answerTextController,
            decoration: InputDecoration(
              hintText: 'Leave an answer',
              hintStyle: theme.subhead.copyWith(color: theme.primaryGray),
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
    );
  }
}
