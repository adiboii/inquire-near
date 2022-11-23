// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class DateDetails extends StatelessWidget {
  const DateDetails({
    super.key,
    required this.dateEnded,
  });

  final String dateEnded;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: theme.primary,
                size: theme.subheadIcon,
              ),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              const AutoSizeText(
                'Date',
                style: theme.subheadBold,
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          Row(
            children: [
              SizedBox(
                width: screenWidth * 0.071,
              ),
              Text(
                dateEnded,
                style: theme.caption1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
