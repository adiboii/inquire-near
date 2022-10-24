// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';
import 'package:inquire_near/data/models/transaction.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class LocationAndOrderDetails extends StatelessWidget {
  const LocationAndOrderDetails(
      {Key? key, required this.inquiryList, required this.transaction})
      : super(key: key);
  final InquiryList inquiryList;
  final INTransaction transaction;
  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: theme.primary,
                size: theme.subheadIcon,
              ),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              const AutoSizeText(
                'Location',
                style: theme.subheadBold,
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          Row(
            children: [
              SizedBox(
                width: screenWidth * 0.071,
              ),
              Image.asset(
                'assets/images/logos/BIR.png', //TODO: update to StoreData
                width: screenWidth * 0.1,
              ),
              SizedBox(
                width: screenWidth * 0.03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    transaction.store,
                    style: theme.caption1,
                  ),
                  const AutoSizeText(
                    'SM Seaside Cebu',
                    style: theme.caption1,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.04,
          ),
          Row(
            children: [
              const Icon(
                Icons.receipt,
                color: theme.primary,
                size: theme.subheadIcon,
              ),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              const AutoSizeText(
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
              const AutoSizeText(
                'Inquiries',
                style: theme.caption1,
              ),
              AutoSizeText(
                '${inquiryList.noOfInquiries} x PHP 25.00',
                style: theme.caption1,
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AutoSizeText(
                'Require Proof',
                style: theme.caption1,
              ),
              AutoSizeText(
                '${inquiryList.noOfRequireProof} x PHP 5.00',
                style: theme.caption1,
              ),
            ],
          ),
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
              const AutoSizeText(
                'Total Amount',
                style: theme.caption1,
              ),
              AutoSizeText(
                'PHP ${transaction.amount.toStringAsFixed(2)}',
                style: theme.headline,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
