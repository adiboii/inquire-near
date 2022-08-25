import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryContainer extends StatefulWidget {
  const InquiryContainer({
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
  State<InquiryContainer> createState() => _InquiryContainerState();
}

class _InquiryContainerState extends State<InquiryContainer> {
  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.3,
      width: double.infinity,
      child: Column(
        children: [
          Column(
            children: [
              AutoSizeText(
                widget.question,
                style: theme.subhead,
              ),
              AutoSizeText(
                'Attached photos: ${widget.nAttachedPhotos}',
                style: theme.caption2,
              ),
              AutoSizeText(
                'Require proof: ${widget.requiresProof}',
                style: theme.caption2,
              ),
              ButtonOutline(
                label: 'Add Reply',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
