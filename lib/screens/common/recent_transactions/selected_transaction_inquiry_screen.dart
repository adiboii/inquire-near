// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/components/inquiry_image.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/screens/client/Add_Inquiry_Screen/widgets/add_title_bar.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class SelectedTransactionInquiryScreen extends StatefulWidget {
  SelectedTransactionInquiryScreen({
    Key? key,
    this.index = 1,
  }) : super(key: key);
  final answerTextController = TextEditingController();
  final int index;

  @override
  State<SelectedTransactionInquiryScreen> createState() =>
      _SelectedTransactionInquiryScreenState();
}

class _SelectedTransactionInquiryScreenState
    extends State<SelectedTransactionInquiryScreen> {
  Inquiry? inquiry;

  @override
  void initState() {
    super.initState();
    inquiry =
        BlocProvider.of<InquiryBloc>(context).inquiries.elementAt(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: theme.kScreenPadding.copyWith(top: 0),
              child: Column(
                children: [
                  InquiryTitleBar(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    pageLabel: 'Inquiry ${widget.index + 1}',
                    buttonLabel: '',
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: screenHeight * 0.02,
                                backgroundImage: const AssetImage(
                                  'assets/images/illustrations/profile.png',
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              Expanded(
                                child: AutoSizeText(
                                  inquiry!.question,
                                  style: theme.subhead,
                                  wrapWords: true,
                                ),
                              ),
                            ],
                          ),
                          (inquiry!.imageUrl != null)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 24, 0, 10),
                                  child: InquiryImage(
                                    imageUrl: inquiry!.imageUrl,
                                  ),
                                )
                              : const SizedBox(),
                          AnswerContainer(
                            answer: inquiry!.answerMessage!,
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                          ),
                          (inquiry!.answerImageUrl != null)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 24, 0, 10),
                                  child: InquiryImage(
                                    imageUrl: inquiry!.answerImageUrl,
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            height: screenHeight * 0.1,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnswerContainer extends StatelessWidget {
  const AnswerContainer({
    Key? key,
    required this.answer,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  final String answer;
  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      verticalDirection: VerticalDirection.up,
      children: [
        Expanded(
          child: Text(
            answer,
            textAlign: TextAlign.end,
            maxLines: null,
          ),
        ),
        SizedBox(
          width: screenWidth * 0.02,
        ),
        CircleAvatar(
          radius: screenHeight * 0.02,
          backgroundImage: const AssetImage(
            'assets/images/illustrations/profile.png',
          ),
        ),
      ],
    );
  }
}
