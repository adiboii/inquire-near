// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

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
