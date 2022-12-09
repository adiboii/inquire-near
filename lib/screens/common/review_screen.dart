// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/feedback/feedback_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/components/bordered_profile_picture.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/enums/role.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class FeedbackScreen extends StatefulWidget {
  final String recepientId;
  final String feedbackerId;
  const FeedbackScreen(
      {Key? key, required this.recepientId, required this.feedbackerId})
      : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _reviewTextController = TextEditingController();
  int rating = 0;
  INTransaction? transaction;
  INUser? user;
  String? userId;
  late Role role;
  bool hasRated = false;

  void _submitFeedback(context, Role role) {
    BlocProvider.of<InquiryBloc>(context).add(ClearInquiry());
    BlocProvider.of<TransactionBloc>(context).add(ClearTransaction());
    BlocProvider.of<TransactionBloc>(context).add(GetRecentTransaction(
        role: role, userId: BlocProvider.of<AuthBloc>(context).user!.uid!));
    BlocProvider.of<FeedbackBloc>(context).add(
      SubmitFeedbackRequested(
        widget.feedbackerId,
        widget.recepientId,
        rating,
        _reviewTextController.text,
        transaction!.id!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var transactionBloc = BlocProvider.of<TransactionBloc>(context);

    transaction = transactionBloc.transaction;

    if (widget.recepientId == transactionBloc.client!.uid) {
      user = BlocProvider.of<TransactionBloc>(context).client;
      role = Role.inquirer;
    } else {
      user = BlocProvider.of<TransactionBloc>(context).inquirer;
      role = Role.client;
    }

    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: theme.kScreenPadding,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const AutoSizeText(
                        'Tell us about your experience',
                        style: theme.headline,
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      const AutoSizeText(
                        'Your feedback will help us\nimprove your inquiring needs',
                        textAlign: TextAlign.center,
                        style: theme.footnote,
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      const BorderedProfilePicture(),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      AutoSizeText(
                        "${user!.firstName} ${user!.lastName}",
                        style: theme.subheadBold,
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      RatingBar(
                        ratingWidget: RatingWidget(
                          full: const Icon(
                            Icons.star,
                            color: theme.primaryYellow,
                          ),
                          half: const Icon(
                            Icons.star,
                            color: Colors.grey,
                          ),
                          empty: const Icon(
                            Icons.star,
                            color: Colors.grey,
                          ),
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            final newRating =
                                int.parse(rating.toString().split('.')[0]);
                            this.rating = newRating;
                            rating == 0 ? hasRated = false : hasRated = true;
                          });
                        },
                        itemSize: screenHeight * 0.035,
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            4.0,
                          ),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        width: double.infinity,
                        height: screenHeight * 0.38,
                        child: TextField(
                          controller: _reviewTextController,
                          decoration: const InputDecoration(
                            hintText: 'Leave a Review',
                            hintStyle: theme.caption1,
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  ButtonOutline(
                    color: (hasRated) ? theme.primary : theme.gray,
                    textColor: (hasRated) ? theme.primary : theme.gray,
                    label: 'Finish',
                    height: screenHeight * 0.07,
                    style: theme.caption1Bold,
                    onTap: (hasRated)
                        ? () {
                            _submitFeedback(context, role);
                            Navigator.pushNamedAndRemoveUntil(context,
                                clientDashboardRoute, (route) => false);
                          }
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "You are required to rate the client."),
                              ),
                            );
                          },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
