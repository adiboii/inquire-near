// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquirerProof extends StatelessWidget {
  const InquirerProof(
      {Key? key,
      required this.hasProof,
      required this.showWidget,
      this.showStatus = true})
      : super(key: key);

  final bool showStatus;
  final bool hasProof;
  final bool showWidget;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            Text(
              "Requires proof",
              style: theme.caption2.copyWith(
                color: (!hasProof) ? theme.red : theme.green,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            (!hasProof)
                ? (showStatus)
                    ? const Icon(Icons.error, size: 17, color: theme.red)
                    : const SizedBox()
                : const Icon(Icons.check_circle, size: 17, color: theme.green),
            SizedBox(
              width: screenWidth * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
