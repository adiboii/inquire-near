// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/cards.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryListScreen extends StatefulWidget {
  const InquiryListScreen({Key? key}) : super(key: key);

  @override
  State<InquiryListScreen> createState() => _InquiryListScreenState();
}

class _InquiryListScreenState extends State<InquiryListScreen> {
  final inquiryList = <Inquiry>[];
  Future<void> _addInquiry(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.pushNamed(
      context,
      '/add_inquiry',
    ) as Inquiry?;

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;
    if (result == null) return;
    inquiryList.add(result);
    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text("$result")));
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding.copyWith(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: const AssetImage('assets/images/logos/BIR.png'),
                        width: screenWidth * 0.12,
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      const Text(
                        "Bureau of Internal Revenue\nCebu South Branch",
                        style: theme.subheadBold,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "What do you need from here?",
                style: theme.headline.copyWith(fontSize: 16),
              ),
              SizedBox(height: screenHeight * 0.02),
              (inquiryList.isEmpty)
                  ? AddInquiryCard(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      onTap: () {
                        _addInquiry(context);
                      },
                    )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: InquiryList(
                          inquiryList: inquiryList,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        ),
                      ),
                    ),
              (inquiryList.isNotEmpty)
                  ? Column(
                      children: [
                        SizedBox(height: screenHeight * 0.04),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ButtonOutline(
                              label: "Add an inquiry",
                              style: theme.caption1Bold,
                              width: screenWidth * 0.40,
                              height: screenHeight * 0.06,
                              onTap: () {
                                _addInquiry(context);
                              },
                            ),
                            ButtonFill(
                                label: "Finish",
                                style: theme.caption1Bold,
                                width: screenWidth * 0.40,
                                height: screenHeight * 0.06),
                          ],
                        )
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class InquiryList extends StatelessWidget {
  final List<Inquiry> inquiryList;

  const InquiryList({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.inquiryList,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: inquiryList.length,
      itemBuilder: ((context, index) {
        final inquiryItem = inquiryList[index];
        return Dismissible(
          key: Key(inquiryItem.message!),
          onDismissed: (direction) {
            inquiryList.removeAt(index);
          },
          background: Container(color: theme.red),
          child: InquiryItem(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            label: inquiryList[index].getInquiry()!,
            attachedPhotos: inquiryList[index].getImage() != null ? 1 : 0,
            requireProof: inquiryList[index].getRequireProof()!,
          ),
        );
      }),
      scrollDirection: Axis.vertical,
    );
  }
}

class InquiryItem extends StatefulWidget {
  const InquiryItem(
      {Key? key,
      required this.screenHeight,
      required this.screenWidth,
      required this.label,
      required this.attachedPhotos,
      required this.requireProof})
      : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final String label;
  final int attachedPhotos;
  final bool requireProof;

  @override
  State<InquiryItem> createState() => _InquiryItemState();
}

class _InquiryItemState extends State<InquiryItem> {
  late String requireProofString;

  @override
  Widget build(BuildContext context) {
    requireProofString = widget.requireProof ? "True" : "False";

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: widget.screenWidth * 0.05,
              backgroundImage: const AssetImage(
                'assets/images/illustrations/profile.png',
              ),
            ),
            SizedBox(width: widget.screenWidth * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  widget.label,
                  style: theme.subhead,
                ),
                SizedBox(height: widget.screenHeight * 0.01),
                Text(
                  "Attached photos: ${widget.attachedPhotos}",
                  style: theme.caption1,
                ),
                SizedBox(height: widget.screenHeight * 0.01),
                Text(
                  "Require Proof: $requireProofString",
                  style: theme.caption1,
                ),
                SizedBox(height: widget.screenHeight * 0.01),
              ],
            ),
          ],
        ),
        const Divider(height: 20),
      ],
    );
  }
}
