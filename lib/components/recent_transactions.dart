import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inquire_near/components/list.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        AutoSizeText(
          'Recent Transactions',
          style: theme.headline,
        ),
        InListItem(
          color: Colors.green,
          type: 'BDO',
          amount: '1234',
        ),
      ],
    );
  }
}
