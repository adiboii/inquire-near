// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryItem extends StatefulWidget {
  const InquiryItem(
      {Key? key,
      required this.screenHeight,
      required this.screenWidth,
      required this.label,
      required this.attachedPhotos,
      required this.requireProof})
      : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final String label;
  final int attachedPhotos;
  final bool requireProof;

  @override
  State<InquiryItem> createState() => _InquiryItemState();
}

class _InquiryItemState extends State<InquiryItem> {
  late String requireProofString;

  @override
  Widget build(BuildContext context) {
    requireProofString = widget.requireProof ? "True" : "False";

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: widget.screenWidth * 0.05,
              backgroundImage: const AssetImage(
                'assets/images/illustrations/profile.png',
              ),
            ),
            SizedBox(width: widget.screenWidth * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  widget.label,
                  style: theme.subhead,
                ),
                SizedBox(height: widget.screenHeight * 0.01),
                Text(
                  "Attached photos: ${widget.attachedPhotos}",
                  style: theme.caption1,
                ),
                SizedBox(height: widget.screenHeight * 0.01),
                Text(
                  "Require Proof: $requireProofString",
                  style: theme.caption1,
                ),
                SizedBox(height: widget.screenHeight * 0.01),
              ],
            ),
          ],
        ),
        const Divider(height: 20),
      ],
    );
  }
}
