// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/constants.dart' as constants;
import 'package:inquire_near/data/models/inquiry_list.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    Key? key,
    required this.transaction,
    required this.inquiryList,
  }) : super(key: key);

  final INTransaction transaction;
  final InquiryList inquiryList;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: screenWidth * 0.02,
            ),
            const Text(
              'Order',
              style: theme.subheadBold,
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.015,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Inquiries',
              style: theme.caption1,
            ),
            Text(
              '${inquiryList.noOfInquiries} x PHP ${constants.inquiryPrice.toStringAsFixed(2)}',
              style: theme.caption1,
            ),
          ],
        ),
        inquiryList.noOfRequireProof != 0
            ? Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Require Proof',
                        style: theme.caption1,
                      ),
                      Text(
                        '${inquiryList.noOfRequireProof} x PHP ${constants.requireProofPrice.toStringAsFixed(2)}',
                        style: theme.caption1,
                      ),
                    ],
                  )
                ],
              )
            : const SizedBox(),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        const Divider(
          thickness: 0.9,
          color: Colors.black,
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total Amount',
              style: theme.caption1,
            ),
            Text(
              'PHP ${transaction.amount?.toStringAsFixed(2)}',
              style: theme.headline,
            ),
          ],
        ),
      ],
    );
  }
}
