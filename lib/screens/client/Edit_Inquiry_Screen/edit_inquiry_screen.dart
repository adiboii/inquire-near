// Dart imports:
import 'dart:developer';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/components/bottom_bar.dart';
import 'package:inquire_near/components/input_validator.dart';
import 'package:inquire_near/components/inquiry_image.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/screens/client/Add_Inquiry_Screen/widgets/add_inquiry_input.dart';
import 'package:inquire_near/screens/client/Add_Inquiry_Screen/widgets/add_title_bar.dart';
import 'package:inquire_near/screens/client/Edit_Inquiry_Screen/widgets/edit_inquiry_input.dart';
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
  final inputValidator = InputValidator();
  final _formKey = GlobalKey<FormState>();

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
    image = inquiry.image;
    requireProof = inquiry.requireProof;
    inquiryController.text = inquiry.question;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    log("Here");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SafeArea(
            top: false,
            child: Padding(
              padding: theme.kScreenPadding,
              child: Column(
                children: [
                  InquiryTitleBar(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    pageLabel: "Edit Inquiry",
                    buttonLabel: "Edit",
                    showButton: true,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          inquiry = Inquiry(
                              question: inquiryController.text.trim(),
                              requireProof: requireProof,
                              image: image);
                        });

                        BlocProvider.of<InquiryBloc>(context).add(
                            EditInquiryRequested(
                                index: widget.index, editedInquiry: inquiry));

                        Navigator.pop(context);
                      }
                    },
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 100),
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: AddInquiryInput(
                                screenWidth: screenWidth,
                                inquiryContoller: inquiryController,
                                validator: (value) {
                                  log("Value: $value");
                                  if (inputValidator.isEmpty(value)) {
                                    return 'This is a required field';
                                  } else if (inputValidator
                                      .isWhiteSpaceOnly(value)) {
                                    return 'Not a valid inquiry';
                                  }
                                  return null;
                                },
                              ),
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
                ],
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
