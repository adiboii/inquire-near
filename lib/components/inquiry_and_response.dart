import 'package:flutter/material.dart';
import 'package:inquire_near/components/inquiry_container.dart';
import 'package:inquire_near/components/inquiry_detail.dart';
import 'package:inquire_near/components/response.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryAndResponse extends StatelessWidget {
  const InquiryAndResponse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        InquiryDetail(
          question: 'Is it open right now?',
          nAttachedPhotos: 1,
          requiresProof: true,
        ),
        SizedBox(
          height: screenHeight * 0.05,
        ),
        Response(
          answer: 'Yes',
          nAttachedPhotos: 1,
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
        InquiryDetail(
          question: 'Are there a lot of people right now?',
          nAttachedPhotos: 1,
          requiresProof: true,
        ),
        SizedBox(
          height: screenHeight * 0.05,
        ),
        Response(
          answer: 'Yessir',
          nAttachedPhotos: 1,
        ),
        SizedBox(
          height: screenHeight * 0.05,
        ),
        Divider(
          thickness: screenHeight * 0.0004,
          color: Colors.black,
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        InquiryDetail(
          question: 'What is the current priority number?',
          nAttachedPhotos: 1,
          requiresProof: true,
        ),
        SizedBox(
          height: screenHeight * 0.05,
        ),
        Response(
          answer: '21',
          nAttachedPhotos: 1,
        ),
        SizedBox(
          height: screenHeight * 0.05,
        ),
      ],
    );
  }
}
