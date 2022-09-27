// Flutter imports:
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/cards.dart';
import 'package:inquire_near/components/inqury_list.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryListScreen extends StatefulWidget {
  const InquiryListScreen({Key? key}) : super(key: key);

  @override
  State<InquiryListScreen> createState() => _InquiryListScreenState();
}

class _InquiryListScreenState extends State<InquiryListScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final inquiryList = <Inquiry>[];

  Future<void> _addInquiry(BuildContext context) async {
    final result = await Navigator.pushNamed(
      context,
      '/add_inquiry',
    ) as Inquiry?;

    if (!mounted || result == null) return;

    setState(() {
      inquiryList.add(result);
    });
  }

  Future<void> saveInquiry(context) async {
    for (Inquiry inquiry in inquiryList) {
      await inquiry.saveToFirebaseStorage(user.uid.toString());
    }

    BlocProvider.of<InquiryBloc>(context)
        .add(CreateInquiryRequested(inquiryList: inquiryList));
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    int length = inquiryList.length;

    void updateLength(int value) {
      setState(() {
        length = value;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding.copyWith(top: 20),
          child: BlocConsumer<InquiryBloc, InquiryState>(
            listener: (context, state) {
              if (state is InquiryFinished) {
                Navigator.pushNamed(context, '/finding_inquirer');
              }
            },
            builder: (context, state) {
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is InquiryInitial) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.black),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image: const AssetImage(
                                  'assets/images/logos/BIR.png'),
                              width: screenWidth * 0.12,
                            ),
                            SizedBox(width: screenWidth * 0.05),
                            const Text(
                              "Bureau of Internal Revenue\nCebu South Branch",
                              style: theme.subheadBold,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "What do you need from here?",
                      style: theme.headline.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    (length == 0)
                        ? AddInquiryCard(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            onTap: () {
                              _addInquiry(context);
                              setState(() {
                                length = inquiryList.length;
                              });
                            },
                          )
                        : Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: InquiryList(
                                inquiryList: inquiryList,
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                                updateLength: updateLength,
                              ),
                            ),
                          ),
                    (inquiryList.isNotEmpty)
                        ? Column(
                            children: [
                              SizedBox(height: screenHeight * 0.04),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ButtonOutline(
                                    label: "Add an inquiry",
                                    style: theme.caption1Bold,
                                    width: screenWidth * 0.40,
                                    height: screenHeight * 0.06,
                                    onTap: () {
                                      _addInquiry(context);
                                    },
                                  ),
                                  ButtonFill(
                                    label: "Finish",
                                    style: theme.caption1Bold,
                                    width: screenWidth * 0.40,
                                    height: screenHeight * 0.06,
                                    onTap: () {
                                      saveInquiry(context);
                                    },
                                  ),
                                ],
                              )
                            ],
                          )
                        : const SizedBox(),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
