// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/components/inquiry_item.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';
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
  Future<Inquiry> _editInquiry(
      BuildContext context, Inquiry inquiryToBeEdited) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) =>
                EditInquiryScreen(inquiry: inquiryToBeEdited)))) as Inquiry;
    //if (!mounted || result == null) return Inquiry();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.inquiryList.length,
      itemBuilder: ((context, index) {
        final inquiryItem = widget.inquiryList[index];
        return Dismissible(
          key: Key(inquiryItem.getID()),
          onDismissed: (direction) {
            setState(() {
              widget.inquiryList.removeAt(index);
            });
          },
          background: Container(color: theme.red),
          child: InkWell(
            onTap: () async {
              Inquiry editedInquiry =
                  await _editInquiry(context, widget.inquiryList[index]);

              setState(() {
                widget.inquiryList[index] = editedInquiry;
              });
            },
            child: InquiryItem(
              screenHeight: widget.screenHeight,
              screenWidth: widget.screenWidth,
              index: (index + 1).toString(),
              label: widget.inquiryList[index].getInquiry(),
              attachedPhotos: widget.inquiryList[index].numOfImagesAttached(),
              requireProof: widget.inquiryList[index].getRequireProof(),
            ),
          ),
        );
      }),
      scrollDirection: Axis.vertical,
    );
  }
}
