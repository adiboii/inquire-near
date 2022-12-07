// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/report/report_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/choose_report_type.dart';
import 'package:inquire_near/components/input_report.dart';
import 'package:inquire_near/components/input_validator.dart';
import 'package:inquire_near/components/page_title.dart';
import 'package:inquire_near/enums/role.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ReportScreen extends StatefulWidget {
  final bool reportByClient;
  final Role? role;
  const ReportScreen({
    super.key,
    required this.reportByClient,
    this.role,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  String? recepient;
  String? reporter;
  String? transactionId;
  InputValidator inputValidator = InputValidator();

  void _submitReport(context) {
    if (inputValidator.isEmpty(titleTextController.text) ||
        inputValidator.isEmpty(descriptionTextController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all the details.'),
        ),
      );
      return;
    }
    BlocProvider.of<ReportBloc>(context).add(
      SubmitReportRequested(
        title: titleTextController.text.trim(),
        description: descriptionTextController.text.trim(),
        recepientId: recepient!,
        reporterId: reporter!,
        transactionId: transactionId!,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Report successfully submitted.'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    transactionId = BlocProvider.of<TransactionBloc>(context).transaction!.id;
    if (widget.role == Role.client) {
      recepient = BlocProvider.of<TransactionBloc>(context).inquirer!.uid;
      reporter = BlocProvider.of<TransactionBloc>(context).client!.uid;
    } else {
      recepient = BlocProvider.of<TransactionBloc>(context).client!.uid;
      reporter = BlocProvider.of<TransactionBloc>(context).inquirer!.uid;
    }
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
                    _submitReport(context);
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
