// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/choose_report_type.dart';
import 'package:inquire_near/components/input_report.dart';
import 'package:inquire_near/components/page_title.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ReportScreen extends StatefulWidget {
  final bool reportByClient;
  const ReportScreen({super.key, required this.reportByClient});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController description = TextEditingController();
  TextEditingController issue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    bool monetary = false;
    bool rating = false;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: theme.kScreenPadding.copyWith(top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageTitle(title: "What seems to be the problem?"),
                SizedBox(height: screenHeight * 0.025),
                if (widget.reportByClient)
                  ChooseReportType(
                    screenHeight: screenHeight,
                    monetary: monetary,
                    rating: rating,
                  ),
                SizedBox(height: screenHeight * 0.025),
                InputReport(
                  screenHeight: screenHeight,
                  description: description,
                  issue: issue,
                  reportByClient: widget.reportByClient,
                ),
                SizedBox(height: screenHeight * 0.025),
                ButtonOutline(
                  label: "Submit Report",
                  style: theme.caption1Bold,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
