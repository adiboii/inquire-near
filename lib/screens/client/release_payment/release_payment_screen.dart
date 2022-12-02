// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/date_details.dart';
import 'package:inquire_near/components/location_and_order_details.dart';
import 'package:inquire_near/components/page_title.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/enums/role.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/utils.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ReleasePaymentScreen extends StatefulWidget {
  const ReleasePaymentScreen({Key? key}) : super(key: key);

  @override
  State<ReleasePaymentScreen> createState() => _ReleasePaymentScreenState();
}

class _ReleasePaymentScreenState extends State<ReleasePaymentScreen> {
  late INTransaction transaction;

  @override
  void initState() {
    super.initState();
    transaction = BlocProvider.of<TransactionBloc>(context).transaction!;
    BlocProvider.of<TransactionBloc>(context)
        .add((ViewRecentTransaction(transaction: transaction)));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding,
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is TransactionLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is RetrievedTransactionDetails) {
                String dateEnded = formatDate(state.transaction.dateTimeEnded!);

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          PageTitle(
                              title: "Release Payment",
                              showButton: false,
                              onTap: () {
                                BlocProvider.of<TransactionBloc>(context).add(
                                    GetRecentTransaction(
                                        role: Role.client,
                                        userId:
                                            BlocProvider.of<AuthBloc>(context)
                                                .user!
                                                .uid!));
                                BlocProvider.of<InquiryBloc>(context)
                                    .add(DiscardInquiry());
                                Navigator.pop(context);
                              }),
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
                          label: "Release Payment",
                          style: theme.caption2,
                          onTap: () {
                            BlocProvider.of<InquiryBloc>(context).add(
                                GetClientInquiries(
                                    inquiryListID: transaction.inquiryListId));
                            Navigator.pushNamed(
                                context, transactionInquiryListRoute,
                                arguments: true);
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
    );
  }
}
