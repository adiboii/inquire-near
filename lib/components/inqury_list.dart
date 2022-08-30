// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/components/inquiry_container.dart';

class InquiryList extends StatelessWidget {
  const InquiryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        const InquiryContainer(
          question: 'Is it open right now?',
          nAttachedPhotos: 1,
          requiresProof: true,
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Divider(
          thickness: screenHeight * 0.0004,
          color: Colors.black,
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        const InquiryContainer(
          question: 'Are there a lot of people right now?',
          nAttachedPhotos: 1,
          requiresProof: true,
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Divider(
          thickness: screenHeight * 0.0004,
          color: Colors.black,
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        const InquiryContainer(
          question: 'What is the current priority number?',
          nAttachedPhotos: 1,
          requiresProof: true,
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Divider(
          thickness: screenHeight * 0.0004,
          color: Colors.black,
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        const InquiryContainer(
          question: 'What time does it close?',
          nAttachedPhotos: 1,
          requiresProof: true,
        ),
      ],
    );
  }
}
