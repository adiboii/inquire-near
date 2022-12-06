// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/bloc/bloc/inquirer/inquirer_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/components/bordered_profile_picture.dart';
import 'package:inquire_near/components/location_and_order_details.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/screens/common/custom_alert_dialog.dart';
import 'package:inquire_near/screens/inquirer/client_found/widgets/accept_request_button.dart';
import 'package:inquire_near/screens/inquirer/client_found/widgets/reject_request_button.dart';
import 'package:inquire_near/screens/inquirer/client_found/widgets/review_details.dart';
import 'package:inquire_near/screens/inquirer/client_found/widgets/view_inquiries_button.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ClientFoundScreen extends StatefulWidget {
  const ClientFoundScreen({Key? key}) : super(key: key);

  @override
  State<ClientFoundScreen> createState() => _ClientFoundScreenState();
}

class _ClientFoundScreenState extends State<ClientFoundScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TransactionBloc>(context).add(GetHiringRequestDetails(
        hiringRequest: BlocProvider.of<InquirerBloc>(context).hiringRequest!));
    BlocProvider.of<TransactionBloc>(context).add(GetTransactionDetails());
  }

  showAlertDialog(BuildContext context) async {
    // show the dialog
    bool result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Reject Request',
          content: 'Do you want to reject this hiring request?',
          successText: 'Yes',
          onSuccess: () {
            BlocProvider.of<InquirerBloc>(context).add(RejectRequest());
            Navigator.pop(context, true);
          },
          failText: 'Cancel',
          onFail: () {
            Navigator.pop(context, false);
          },
        );
      },
    );

    if (result) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        showAlertDialog(context);
        return true;
      },
      child: Scaffold(
        body: SafeArea(
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
                    BlocProvider.of<InquiryBloc>(context).add(
                        GetClientInquiries(
                            inquiryListID: state.inquiryList.id!));

                    String firstName = state.userData['user'].firstName;
                    String lastName = state.userData['user'].lastName;
                    String clientName = "$firstName $lastName";

                    double averageRating = state.userData['averageRating'];
                    int numberOfFeedbacks = state.userData['numberOfFeedbacks'];
                    String reviewDetails =
                        "${averageRating.toStringAsFixed(1)} ($numberOfFeedbacks reviews)";

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: [
                              const AutoSizeText(
                                'You\'re Hired',
                                style: theme.headline,
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              const BorderedProfilePicture(),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              AutoSizeText(
                                clientName,
                                style: theme.subheadBold,
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              ReviewDetails(
                                  screenWidth: screenWidth,
                                  numberOfFeedbacks: numberOfFeedbacks,
                                  reviewDetails: reviewDetails),
                              SizedBox(
                                height: screenHeight * 0.04,
                              ),
                              LocationAndOrderDetails(
                                  transaction: state.transaction,
                                  inquiryList: state.inquiryList),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              ViewInquiriesButton(
                                  inquiryListID: state.inquiryList.id!),
                            ],
                          ),
                          Column(
                            children: [
                              AcceptRequestButton(
                                  transaction: state.transaction),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              const RejectRequestButton(),
                            ],
                          ),
                        ],
                      ),
                    );
                  }

                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
