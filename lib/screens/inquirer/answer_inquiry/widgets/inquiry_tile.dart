// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryTile extends StatefulWidget {
  const InquiryTile({
    super.key,
    this.index = 1,
    this.isAnswered = false,
    this.question = "Are you okay?",
    this.withAttachments = true,
    this.requiresProof = true,
    required this.onSelectInquiry(),
  });
  final int index;
  final bool isAnswered;
  final String question;
  final bool withAttachments;
  final bool requiresProof;
  final void Function()? onSelectInquiry;

  @override
  State<InquiryTile> createState() => _InquiryTileState();
}

class _InquiryTileState extends State<InquiryTile> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onSelectInquiry,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    (widget.isAnswered) ? theme.green : theme.primary,
                radius: screenWidth * 0.05,
                child: (widget.isAnswered)
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: screenWidth * 0.035,
                      )
                    : Text(
                        widget.index.toString(),
                        style: theme.caption2Bold.copyWith(
                          color: Colors.white,
                        ),
                      ),
              ),
              SizedBox(
                width: screenWidth * 0.04,
              ),
              // Questions
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.025,
                    width: screenWidth * 0.65,
                    child: Text(
                      widget.question,
                      style: theme.subhead,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  (widget.withAttachments)
                      ? Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Text(
                              'With Attachments',
                              style: theme.caption2.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  (widget.requiresProof)
                      ? Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Text(
                              'Requires Proof',
                              style: theme.caption2.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  ButtonOutline(
                    height: screenHeight * 0.05,
                    width: screenWidth * 0.65,
                    fontSize: 11,
                    label: (widget.isAnswered) ? 'Edit Reply' : 'Add Reply',
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          const Divider(
            height: 20,
          ),
        ],
      ),
    );
  }
}
