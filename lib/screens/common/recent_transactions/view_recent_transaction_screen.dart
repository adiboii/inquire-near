// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/screens/common/report_screen.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/bloc/bloc/inquirer/inquirer_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/components/bordered_profile_picture.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/date_details.dart';
import 'package:inquire_near/components/location_and_order_details.dart';
import 'package:inquire_near/components/page_title.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/enums/role.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ViewTransactionScreen extends StatefulWidget {
  final INTransaction transaction;
  final Role role;
  const ViewTransactionScreen(
      {Key? key, required this.transaction, required this.role})
      : super(key: key);

  @override
  State<ViewTransactionScreen> createState() => _ViewTransactionScreenState();
}

class _ViewTransactionScreenState extends State<ViewTransactionScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TransactionBloc>(context)
        .add((ViewRecentTransaction(transaction: widget.transaction)));
  }

  void rebuildWidgetAndClearInquiry() {
    BlocProvider.of<TransactionBloc>(context).add(GetRecentTransaction(
        role: widget.role,
        userId: BlocProvider.of<AuthBloc>(context).user!.uid!));
    BlocProvider.of<InquiryBloc>(context).add(ClearInquiry());
    BlocProvider.of<TransactionBloc>(context).add(ClearTransaction());
  }

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String userType;
    String name;

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          rebuildWidgetAndClearInquiry();
          return true;
        },
        child: SafeArea(
          top: false,
          child: Padding(
            padding: theme.kScreenPadding.copyWith(top: 20),
            child: BlocListener<InquirerBloc, InquirerState>(
              listener: (context, state) {
                if (state is AcceptedRequest) {
                  Navigator.of(context).pushNamed(waitingForClientToPayRoute);
                }
              },
              child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is RetrievedTransactionDetails) {
                    if (widget.role == Role.client) {
                      userType = "Inquirer";
                      name =
                          "${BlocProvider.of<TransactionBloc>(context).inquirer!.firstName!} ${BlocProvider.of<TransactionBloc>(context).inquirer!.lastName!}";
                    } else {
                      userType = "Client";
                      name =
                          "${BlocProvider.of<TransactionBloc>(context).client!.firstName!} ${BlocProvider.of<TransactionBloc>(context).client!.lastName!}";
                    }

                    String dateEnded = DateFormat("MMMM dd, yyyy")
                        .format(state.transaction.dateTimeEnded!.toDate());

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: [
                              PageTitle(
                                  title: userType,
                                  onTap: () {
                                    rebuildWidgetAndClearInquiry();
                                    Navigator.pop(context);
                                  }),
                              const BorderedProfilePicture(),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              AutoSizeText(
                                name,
                                style: theme.subheadBold,
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              ButtonOutline(
                                label: "Report",
                                style: theme.caption2Bold,
                                textColor: theme.red,
                                color: theme.red,
                                width: screenWidth * 0.35,
                                height: screenHeight * 0.045,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReportScreen(
                                        role: widget.role,
                                        reportByClient: false,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.04,
                              ),
                              DateDetails(dateEnded: dateEnded),
                              SizedBox(
                                height: screenHeight * 0.04,
                              ),
                              LocationAndOrderDetails(
                                  transaction: state.transaction,
                                  inquiryList: state.inquiryList),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                            ],
                          ),
                          ButtonOutline(
                              label: "View Inquiries",
                              style: theme.caption2,
                              onTap: () {
                                BlocProvider.of<InquiryBloc>(context).add(
                                    GetClientInquiries(
                                        inquiryListID:
                                            widget.transaction.inquiryListId));
                                Navigator.pushNamed(
                                    context, transactionInquiryListRoute,
                                    arguments: false);
                              })
                        ],
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
