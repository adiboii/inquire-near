// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/components/inquiry_image.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/screens/client/Add_Inquiry_Screen/widgets/add_inquiry_input.dart';
import 'package:inquire_near/screens/client/Add_Inquiry_Screen/widgets/add_title_bar.dart';
import 'package:inquire_near/screens/inquirer/client_inquiry_list/widgets/require_proof.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ClientInquiryScreen extends StatefulWidget {
  final int index;
  const ClientInquiryScreen({super.key, required this.index});

  @override
  State<ClientInquiryScreen> createState() => _ClientInquiryScreenState();
}

class _ClientInquiryScreenState extends State<ClientInquiryScreen> {
  TextEditingController inquiryController = TextEditingController();
  late bool requireProof;
  late String? imageUrl;
  late Inquiry inquiry;

  @override
  void initState() {
    super.initState();
    setState(() {
      inquiry = BlocProvider.of<InquiryBloc>(context)
          .inquiries
          .elementAt(widget.index);
    });

    requireProof = inquiry.requireProof;
    inquiryController.text = inquiry.question;
    imageUrl = inquiry.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    inquiryController.text = inquiry.question.toString();
    requireProof = inquiry.requireProof;

    int inquiryIndex = widget.index + 1;

    //Inquiry inquiry;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: theme.kScreenPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          InquiryTitleBar(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                            pageLabel: "Inquiry $inquiryIndex",
                            buttonLabel: "Finish",
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          AddInquiryInput(
                            readOnly: true,
                            screenWidth: screenWidth,
                            inquiryContoller: inquiryController,
                          ),
                          const SizedBox(height: 10),
                          RequiresProof(
                            showWidget: requireProof,
                            showStatus: false,
                            hasProof: false,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 24, 0, 10),
                        child: InquiryImage(
                          imageUrl: imageUrl,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
