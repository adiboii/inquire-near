// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/page_title.dart';
import 'package:inquire_near/screens/inquirer/client_inquiry_list/widgets/view_only_inquiry_list.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ClientInquiryListScreen extends StatelessWidget {
  const ClientInquiryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PageTitle(
                  title: "Client's Inquiries",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Expanded(
                  child: ViewOnlyInquiryList(
                      screenHeight: screenHeight, screenWidth: screenWidth),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                ButtonFill(
                  label: 'Finish',
                  style: theme.caption1Bold,
                  height: screenHeight * 0.07,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
