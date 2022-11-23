// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/bloc/bloc/feedback/feedback_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/components/bordered_profile_picture.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ClientFeedbackScreen extends StatefulWidget {
  const ClientFeedbackScreen({Key? key}) : super(key: key);

  @override
  State<ClientFeedbackScreen> createState() => _ClientFeedbackScreenState();
}

class _ClientFeedbackScreenState extends State<ClientFeedbackScreen> {
  final _reviewTextController = TextEditingController();
  int rating = 0;
  INTransaction? transaction;
  INUser? client;
  String? userId;

  bool hasRated = false;

  void _submitFeedback(context) {
    BlocProvider.of<FeedbackBloc>(context).add(
      SubmitFeedbackRequested(
        // TODO: change to inquirer uid (MEL)
        transaction!.clientId,
        userId!,
        rating,
        _reviewTextController.text,
        transaction!.id!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    transaction = BlocProvider.of<TransactionBloc>(context).transaction;
    client = BlocProvider.of<TransactionBloc>(context).client;
    userId = BlocProvider.of<AuthBloc>(context).user!.uid;
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
                        "${client!.firstName} ${client!.lastName}",
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
                            _submitFeedback(context);
                            Navigator.pushReplacementNamed(
                                context, clientDashboardRoute);
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
