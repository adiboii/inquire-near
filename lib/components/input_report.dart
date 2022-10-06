// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

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
