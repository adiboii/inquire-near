// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/report/report_bloc.dart';
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
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  void _clickSubmit(context) {
    BlocProvider.of<ReportBloc>(context).add(
      SubmitReportRequested(
        titleTextController.text,
        descriptionTextController.text,
      ),
    );
  }

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
                PageTitle(
                  title: "What seems to be the problem?",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
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
                  title: titleTextController,
                  description: descriptionTextController,
                  reportByClient: widget.reportByClient,
                ),
                SizedBox(height: screenHeight * 0.025),
                ButtonOutline(
                  label: "Submit Report",
                  style: theme.caption1Bold,
                  onTap: () {
                    _clickSubmit(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
