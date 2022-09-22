import 'package:flutter/material.dart';
import 'package:inquire_near/components/buttons.dart';
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

class InputReport extends StatefulWidget {
  final double screenHeight;
  final TextEditingController description;
  final TextEditingController issue;
  final bool reportByClient;
  const InputReport({
    required this.description,
    required this.issue,
    required this.screenHeight,
    required this.reportByClient,
    Key? key,
  }) : super(key: key);

  @override
  State<InputReport> createState() => _InputReportState();
}

class _InputReportState extends State<InputReport> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Please enter a short title describing the problem",
          style: theme.footnote,
        ),
        SizedBox(height: widget.screenHeight * 0.02),
        TextField(
          controller: widget.description,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding: EdgeInsets.all(10),
          ),
        ),
        SizedBox(height: widget.screenHeight * 0.025),
        const Text(
          "Please elaborate on the issue",
          style: theme.footnote,
        ),
        SizedBox(height: widget.screenHeight * 0.02),
        SizedBox(
          height: (widget.reportByClient)
              ? widget.screenHeight * 0.40
              : widget.screenHeight * 0.55,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: theme.primaryGray),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: widget.issue,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChooseReportType extends StatefulWidget {
  const ChooseReportType({
    Key? key,
    required this.screenHeight,
    required this.monetary,
    required this.rating,
  }) : super(key: key);
  final double screenHeight;
  final bool monetary;
  final bool rating;

  @override
  State<ChooseReportType> createState() => _ChooseReportTypeState();
}

class _ChooseReportTypeState extends State<ChooseReportType> {
  bool monetary = false;
  bool rating = false;

  @override
  void initState() {
    super.initState();
    monetary = widget.monetary;
    rating = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Please choose the option that applies",
          style: theme.footnote,
        ),
        Row(
          children: [
            Checkbox(
              value: monetary,
              onChanged: (val) {
                setState(() {
                  monetary = val!;
                  if (rating) rating = !rating;
                });
              },
            ),
            const Text("Monetary", style: theme.footnote),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: rating,
              onChanged: (val) {
                setState(() {
                  rating = val!;
                  if (monetary) monetary = !monetary;
                });
              },
            ),
            const Text("Rating", style: theme.footnote),
          ],
        ),
      ],
    );
  }
}
