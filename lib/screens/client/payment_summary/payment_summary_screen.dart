// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/bloc/bloc/client/client_bloc.dart';
import 'package:inquire_near/bloc/bloc/payment/payment_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/page_title.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/enums/role.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/screens/client/payment_summary/widgets/location.dart';
import 'package:inquire_near/screens/client/payment_summary/widgets/order_summary.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class PaymentSummaryScreen extends StatefulWidget {
  const PaymentSummaryScreen({Key? key}) : super(key: key);

  @override
  State<PaymentSummaryScreen> createState() => _PaymentSummaryScreenState();
}

class _PaymentSummaryScreenState extends State<PaymentSummaryScreen> {
  void pay(BuildContext context, INTransaction? transaction) {
    if (transaction == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong.")));
    } else {
      BlocProvider.of<PaymentBloc>(context)
          .add(Pay(transaction.amount!, transaction.id!));
    }
  }

  void rebuildWidgetAndClearInquiry() {
    BlocProvider.of<TransactionBloc>(context).add(GetRecentTransaction(
        role: Role.client,
        userId: BlocProvider.of<AuthBloc>(context).user!.uid!));
    BlocProvider.of<InquiryBloc>(context).add(ClearInquiry());
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClientBloc>(context).add(ListenHiringRequest());
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    INTransaction? transaction =
        BlocProvider.of<TransactionBloc>(context).transaction;
    InquiryList inquiryList = BlocProvider.of<InquiryBloc>(context).inquiryList;

    return Scaffold(
      body: BlocListener<ClientBloc, ClientState>(
        listener: (context, state) {
          if (state is RejectedHiringRequest) {
            rebuildWidgetAndClearInquiry();
            BlocProvider.of<TransactionBloc>(context).add(ClearTransaction());
            Navigator.pop(context);
          }
        },
        child: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccessful) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Payment successful.")));
              state.retries = 0;
              Navigator.of(context).pushReplacementNamed(etaScreenRoute);
            }

            if (state is PaymentError) {
              if (state.retries >= 5) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Payment failed. Try again.")));
                state.retries = 0;
              }
            }
          },
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: theme.kScreenPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        PageTitle(title: 'Payment Summary', onTap: () {}),
                        SizedBox(
                          height: screenHeight * 0.075,
                        ),
                        Location(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight),
                        SizedBox(height: screenHeight * 0.05),
                        OrderSummary(
                            transaction: transaction!,
                            inquiryList: inquiryList),
                      ],
                    ),
                  ),
                  ButtonFill(
                      label: "Continue",
                      style: theme.caption1Bold,
                      onTap: () => pay(context, transaction)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
