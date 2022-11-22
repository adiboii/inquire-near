// Flutter imports:
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Color color;
  final String store;
  final Timestamp date;

  const TransactionItem(
      {super.key,
      required this.color,
      required this.store,
      required this.date});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    String transactionDate = DateFormat("MM/dd/yyyy").format(date.toDate());

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.015,
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: theme.primaryGray,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: color,
                    radius: 5,
                  ),
                  const SizedBox(width: 10),
                  Text(store),
                ],
              ),
              Text(
                transactionDate,
                style: theme.caption1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
