// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/cards.dart';
import 'package:inquire_near/components/inqury_list_widget.dart';
import 'package:inquire_near/components/page_title.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryListScreen extends StatefulWidget {
  const InquiryListScreen({Key? key}) : super(key: key);

  @override
  State<InquiryListScreen> createState() => _InquiryListScreenState();
}

class _InquiryListScreenState extends State<InquiryListScreen> {
  List<Inquiry> inquiryList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<InquiryBloc>(context).add(CreateInquiryList());
    inquiryList = BlocProvider.of<InquiryBloc>(context).inquiries;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    InquiryBloc inquiryBloc = BlocProvider.of<InquiryBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding.copyWith(top: 20),
          child: BlocConsumer<InquiryBloc, InquiryState>(
            listener: (c, state) {
              if (state is InquiryFinished) {
                BlocProvider.of<TransactionBloc>(context).add(CreateTransaction(
                    clientID: authBloc.user!.uid!,
                    inquiryListID: inquiryBloc.inquiryList.id!,
                    noOfInquiries: inquiryBloc.inquiryList.noOfInquiries,
                    noOfRequireProof:
                        inquiryBloc.inquiryList.noOfRequireProof));
                Navigator.pushNamed(context, availableInquirersRoute);
              }
            },
            builder: (context, state) {
              if (state is InquiryLoading || state is CreatingInquiryList) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is InquiryInProgress) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageTitle(
                      title: BlocProvider.of<TransactionBloc>(context).store!,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
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
                              Navigator.pushNamed(context, addInquiryRoute);
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
                                      Navigator.pushNamed(
                                          context, addInquiryRoute);
                                    },
                                  ),
                                  ButtonFill(
                                    label: "Finish",
                                    style: theme.caption1Bold,
                                    width: screenWidth * 0.40,
                                    height: screenHeight * 0.06,
                                    onTap: () {
                                      INTransaction? transaction =
                                          BlocProvider.of<TransactionBloc>(
                                                  context)
                                              .transaction;
                                      inquiryBloc.add(FinalizeInquiry(
                                          transaction: transaction));
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
