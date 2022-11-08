// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class FindingInquirerScreen extends StatefulWidget {
  const FindingInquirerScreen({Key? key}) : super(key: key);

  @override
  State<FindingInquirerScreen> createState() => _FindingInquirerScreenState();
}

class _FindingInquirerScreenState extends State<FindingInquirerScreen> {
  Future<bool> editInquiry(BuildContext context) async {
    // ignore: invalid_use_of_visible_for_testing_member
    // Ignored to enable user to edit previous inquiries
    BlocProvider.of<InquiryBloc>(context).add(RevisitInquiry());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => editInquiry(context),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: theme.kScreenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      "Finding an inquirer\nnear the area",
                      style: theme.title3,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Lottie.asset("assets/images/lottie/finding_inquirer.json",
                        height: screenHeight * 0.4),
                    SizedBox(height: screenHeight * 0.01),
                    const Text(
                      "Hold on...",
                      style: theme.headline,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
