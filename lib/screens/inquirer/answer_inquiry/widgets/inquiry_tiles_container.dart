import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/screens/inquirer/answer_inquiry/widgets/inquiry_tile.dart';

class InquiryTilesContainer extends StatelessWidget {
  const InquiryTilesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    List<Inquiry> inquiryList = BlocProvider.of<InquiryBloc>(context).inquiries;
    return ListView.builder(
      itemCount: inquiryList.length,
      itemBuilder: ((context, index) {
        return InquiryTile(
          index: index,
          isAnswered: false,
          question: inquiryList[index].question,
          // TODO: Convert "withAttachedImages" to bool
          withAttachments: true,
          requiresProof: inquiryList[index].requireProof,
        );
      }),
    );
  }
}
