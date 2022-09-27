import 'package:flutter/material.dart';
import 'package:inquire_near/components/inquiry_item.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/screens/client/edit_inquiry_screen.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryList extends StatefulWidget {
  final List<Inquiry> inquiryList;
  final ValueChanged<int> updateLength;
  const InquiryList({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.inquiryList,
    required this.updateLength,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  State<InquiryList> createState() => _InquiryListState();
}

class _InquiryListState extends State<InquiryList> {
  Future<Inquiry> _editInquiry(
      BuildContext context, Inquiry inquiryToBeEdited) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) =>
                EditInquiryScreen(inquiry: inquiryToBeEdited)))) as Inquiry?;

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    // if (!mounted || result == null) return Inquiry();
    return result!;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.inquiryList.length,
      itemBuilder: ((context, index) {
        final inquiryItem = widget.inquiryList[index];
        return Dismissible(
          key: Key(inquiryItem.message!),
          onDismissed: (direction) {
            setState(() {
              widget.inquiryList.removeAt(index);
            });
            widget.updateLength(widget.inquiryList.length);
            //log(widget.inquiryList.length.toString());
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
              label: widget.inquiryList[index].getInquiry()!,
              attachedPhotos:
                  widget.inquiryList[index].getImage() != null ? 1 : 0,
              requireProof: widget.inquiryList[index].getRequireProof()!,
            ),
          ),
        );
      }),
      scrollDirection: Axis.vertical,
    );
  }
}
