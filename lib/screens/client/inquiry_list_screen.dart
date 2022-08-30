import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryListScreen extends StatefulWidget {
  const InquiryListScreen({Key? key}) : super(key: key);

  @override
  State<InquiryListScreen> createState() => _InquiryListScreenState();
}

class _InquiryListScreenState extends State<InquiryListScreen> {
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
              // AddInquiryCard(
              //   screenHeight: screenHeight,
              //   screenWidth: screenWidth,
              //   onTap: () {
              //     Navigator.pushNamed(context, '/add_inquiry');
              //   },
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InquiryList(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                ),
              ),
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
                  ),
                  ButtonFill(
                      label: "Finish",
                      style: theme.caption1Bold,
                      width: screenWidth * 0.40,
                      height: screenHeight * 0.06),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InquiryList extends StatelessWidget {
  const InquiryList({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        InquiryItem(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          label: "Is it open right now?",
          attachedPhotos: 1,
          requireProof: true,
        ),
        InquiryItem(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          label: "Are there a lot of people right now?",
          attachedPhotos: 1,
          requireProof: false,
        ),
        InquiryItem(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          label: "What is the current priority number",
          attachedPhotos: 2,
          requireProof: true,
        ),
        InquiryItem(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          label: "What time does it close?",
          attachedPhotos: 1,
          requireProof: true,
        ),
      ],
    );
  }
}

class InquiryItem extends StatelessWidget {
  InquiryItem(
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
  late String requireProofString;

  @override
  Widget build(BuildContext context) {
    if (requireProof) {
      requireProofString = "True";
    } else {
      requireProofString = "False";
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: screenWidth * 0.05,
              backgroundImage: const AssetImage(
                'assets/images/illustrations/profile.png',
              ),
            ),
            SizedBox(width: screenWidth * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  label,
                  style: theme.subhead,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Attached photos: $attachedPhotos",
                  style: theme.caption1,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Require Proof: $requireProofString",
                  style: theme.caption1,
                ),
                SizedBox(height: screenHeight * 0.01),
              ],
            ),
          ],
        ),
        const Divider(height: 20),
      ],
    );
  }
}
