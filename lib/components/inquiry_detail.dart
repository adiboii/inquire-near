// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryDetail extends StatefulWidget {
  const InquiryDetail({
    Key? key,
    required this.question,
    this.nAttachedPhotos = 0,
    this.requiresProof = false,
  }) : super(key: key);
  // Properties
  final String question;
  final int nAttachedPhotos;
  final bool requiresProof;

  @override
  State<InquiryDetail> createState() => _InquiryDetailState();
}

class _InquiryDetailState extends State<InquiryDetail> {
  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.04,
              child: Checkbox(
                shape: const CircleBorder(
                  side: BorderSide(
                    color: theme.primary,
                  ),
                ),
                value: false,
                onChanged: (value) {},
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    widget.question,
                    style: theme.subhead,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  AutoSizeText(
                    'Attached photos: ${widget.nAttachedPhotos}',
                    style: theme.caption2,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  AutoSizeText(
                    'Require proof: ${widget.requiresProof == true ? 'True' : 'False'}',
                    style: theme.caption2,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
