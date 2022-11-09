// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class RequiresProof extends StatelessWidget {
  const RequiresProof(
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
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            (!hasProof)
                ? (showStatus)
                    ? const Icon(Icons.circle_outlined,
                        size: 15, color: theme.red)
                    : const SizedBox()
                : const Icon(Icons.check_circle, size: 15, color: theme.green),
            const SizedBox(width: 5),
            Text(
              "Requires proof",
              style: theme.caption2.copyWith(
                color: (!hasProof) ? theme.red : theme.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
