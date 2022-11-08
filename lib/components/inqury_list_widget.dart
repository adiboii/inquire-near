// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/components/inquiry_item.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/screens/client/Edit_Inquiry_Screen/edit_inquiry_screen.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryListWidget extends StatefulWidget {
  final List<Inquiry> inquiryList;
  const InquiryListWidget({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.inquiryList,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  State<InquiryListWidget> createState() => _InquiryListWidgetState();
}

class _InquiryListWidgetState extends State<InquiryListWidget> {
  Future<void> _editInquiry(BuildContext context, int index) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => EditInquiryScreen(index: index))));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.inquiryList.length,
      itemBuilder: ((context, index) {
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() {
              BlocProvider.of<InquiryBloc>(context)
                  .add(DeleteInquiryRequested(index: index));
            });
          },
          background: Container(color: theme.red),
          child: InkWell(
            onTap: () async {
              _editInquiry(context, index);
            },
            child: InquiryItem(
              screenHeight: widget.screenHeight,
              screenWidth: widget.screenWidth,
              index: (index + 1).toString(),
              label: widget.inquiryList[index].question,
              withAttachments: widget.inquiryList[index].withAttachedImages,
              requireProof: widget.inquiryList[index].requireProof,
            ),
          ),
        );
      }),
      scrollDirection: Axis.vertical,
    );
  }
}
