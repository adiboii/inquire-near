import 'package:flutter/material.dart';
import 'package:inquire_near/components/inquiry_container.dart';

class InquiryList extends StatelessWidget {
  const InquiryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        InquiryContainer(
          question: 'Is it open right now?',
        ),
      ],
    );
  }
}
