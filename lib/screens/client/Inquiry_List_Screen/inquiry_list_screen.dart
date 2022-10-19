// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/cards.dart';
import 'package:inquire_near/components/inqury_list_widget.dart';
import 'package:inquire_near/components/page_title.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryListScreen extends StatefulWidget {
  const InquiryListScreen({Key? key}) : super(key: key);

  @override
  State<InquiryListScreen> createState() => _InquiryListScreenState();
}

class _InquiryListScreenState extends State<InquiryListScreen> {
  final List<Inquiry> inquiryList = [];
//final user = FirebaseAuth.instance.currentUser!;

  Future<void> addInquiry(BuildContext context) async {
    final result =
        await Navigator.pushNamed(context, '/add_inquiry') as Inquiry?;

    if (!mounted || result == null) return;

    setState(() {
      inquiryList.add(result);
    });
  }

  Future<void> saveInquiry(context) async {
    // loop through all inquries
    // and save them inside firebase
    for (Inquiry inquiry in inquiryList) {
      if (inquiry.uid != null) continue;
      BlocProvider.of<InquiryBloc>(context)
          .add(CreateInquiryRequested(inquiry: inquiry));

      //once saved, save the images
      //inside firebase storage
      if (inquiry.uid != null) {
        await inquiry.saveToFirebaseStorage();
      }
    }

    BlocProvider.of<InquiryBloc>(context).add(FinishInquiry());
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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

              if (state is InquiryInProgress) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PageTitle(title: "Store Name"),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "What do you need from here?",
                      style: theme.headline.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    (inquiryList.isEmpty)
                        ? AddInquiryCard(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            onTap: () {
                              addInquiry(context);
                            },
                          )
                        : Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: InquiryListWidget(
                                inquiryList: inquiryList,
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
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
                                      addInquiry(context);
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
