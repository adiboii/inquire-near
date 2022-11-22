// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/components/inquiry_item.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/screens/common/recent_transactions/selected_transaction_inquiry_screen.dart';

class CompletedInquiryList extends StatefulWidget {
  const CompletedInquiryList({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  State<CompletedInquiryList> createState() => _CompletedInquiryListState();
}

class _CompletedInquiryListState extends State<CompletedInquiryList> {
  Future<void> _viewInquiry(BuildContext context, int index) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) =>
                SelectedTransactionInquiryScreen(index: index))));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InquiryBloc, InquiryState>(
      builder: (context, state) {
        if (state is InquiryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ClientInquiriesRetrieved) {
          List<Inquiry> inquiryList =
              BlocProvider.of<InquiryBloc>(context).inquiries;

          return ListView.builder(
            itemCount: inquiryList.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () async {
                  _viewInquiry(context, index);
                },
                child: InquiryItem(
                  screenHeight: widget.screenHeight,
                  screenWidth: widget.screenWidth,
                  index: (index + 1).toString(),
                  label: inquiryList[index].question,
                  withAttachments: inquiryList[index].withAttachedImages,
                  requireProof: inquiryList[index].requireProof,
                ),
              );
            }),
          );
        }
        return Container();
      },
    );
  }
}
