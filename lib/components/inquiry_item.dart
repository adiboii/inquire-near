// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryItem extends StatefulWidget {
  const InquiryItem(
      {Key? key,
      required this.screenHeight,
      required this.screenWidth,
      required this.label,
      required this.withAttachments,
      required this.requireProof,
      required this.index})
      : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final String? label;
  final bool withAttachments;
  final bool requireProof;
  final String index;

  @override
  State<InquiryItem> createState() => _InquiryItemState();
}

class _InquiryItemState extends State<InquiryItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                SizedBox(
                  height: widget.screenHeight * 0.025,
                  width: widget.screenWidth * 0.65,
                  child: Text(
                    widget.label!,
                    overflow: TextOverflow.ellipsis,
                    style: theme.subhead,
                  ),
                ),
                SizedBox(height: widget.screenHeight * 0.005),
                (widget.withAttachments)
                    ? Column(
                        children: [
                          Text(
                            "With Attachments",
                            style: theme.caption2
                                .copyWith(fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: widget.screenHeight * 0.005),
                        ],
                      )
                    : const SizedBox(height: 0),
                widget.requireProof == true
                    ? Text(
                        "Requires Proof",
                        style: theme.caption2
                            .copyWith(fontStyle: FontStyle.italic),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
        Divider(height: widget.screenHeight * 0.055),
      ],
    );
  }
}
