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
      required this.requireProof,
      required this.index})
      : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final String? label;
  final int attachedPhotos;
  final bool requireProof;
  final String index;

  @override
  State<InquiryItem> createState() => _InquiryItemState();
}

class _InquiryItemState extends State<InquiryItem> {
  late String requireProofString;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: widget.screenWidth * 0.05,
              child: Text(widget.index,
                  style: theme.caption2Bold.copyWith(color: Colors.white)),
            ),
            SizedBox(width: widget.screenWidth * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  widget.label!,
                  style: theme.subhead,
                ),
                SizedBox(height: widget.screenHeight * 0.01),
                Text(
                  "Attached photos: ${widget.attachedPhotos}",
                  style: theme.caption1,
                ),
                SizedBox(height: widget.screenHeight * 0.01),
                Text(
                  "Require Proof: ${widget.requireProof.toString()}",
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
