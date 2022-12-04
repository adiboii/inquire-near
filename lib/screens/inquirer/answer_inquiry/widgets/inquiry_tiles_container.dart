// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/screens/inquirer/answer_inquiry/inquirer_view_selected_inquiry_screen.dart';
import 'package:inquire_near/screens/inquirer/answer_inquiry/widgets/inquiry_tile.dart';

class InquiryTilesContainer extends StatefulWidget {
  const InquiryTilesContainer({super.key});

  @override
  State<InquiryTilesContainer> createState() => _InquiryTilesContainerState();
}

class _InquiryTilesContainerState extends State<InquiryTilesContainer> {
  @override
  Widget build(BuildContext context) {
    List<Inquiry> inquiryList = BlocProvider.of<InquiryBloc>(context).inquiries;
    return ListView.builder(
      itemCount: inquiryList.length,
      itemBuilder: ((context, index) {
        return InquiryTile(
          onSelectInquiry: () async {
            BlocProvider.of<InquiryBloc>(context).add(AnsweringInquiry());
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => InquirerViewSelectedInquiryScreen(
                  inquiryIndex: index + 1,
                ),
              ),
            );
            setState(() {});
          },
          index: index + 1,
          isAnswered: inquiryList[index].answerMessage != null,
          question: inquiryList[index].question,
          withAttachments: inquiryList[index].withAttachedImages,
          requiresProof: inquiryList[index].requireProof,
        );
      }),
    );
  }
}
