import 'package:flutter/material.dart';
import 'package:inquire_near/components/inquiry_item.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';
import 'package:inquire_near/screens/client/Edit_Inquiry_Screen/edit_inquiry_screen.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryListWidget extends StatefulWidget {
  final InquiryList inquiryList;
  final ValueChanged<int> updateLength;
  const InquiryListWidget({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.inquiryList,
    required this.updateLength,
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
      itemCount: widget.inquiryList.getListLength(),
      itemBuilder: ((context, index) {
        final inquiryItem = widget.inquiryList.getList()[index];
        return Dismissible(
          key: Key(inquiryItem.question),
          onDismissed: (direction) {
            setState(() {
              widget.inquiryList.getList().removeAt(index);
            });
            widget.updateLength(widget.inquiryList.getListLength());
          },
          background: Container(color: theme.red),
          child: InkWell(
            onTap: () async {
              Inquiry editedInquiry = await _editInquiry(
                  context, widget.inquiryList.getList()[index]);

              setState(() {
                widget.inquiryList.getList()[index] = editedInquiry;
              });
            },
            child: InquiryItem(
              screenHeight: widget.screenHeight,
              screenWidth: widget.screenWidth,
              label: widget.inquiryList.getList()[index].getInquiry()!,
              attachedPhotos:
                  widget.inquiryList.getList()[index].getImage() != null
                      ? 1
                      : 0,
              requireProof:
                  widget.inquiryList.getList()[index].getRequireProof()!,
            ),
          ),
        );
      }),
      scrollDirection: Axis.vertical,
    );
  }
}
