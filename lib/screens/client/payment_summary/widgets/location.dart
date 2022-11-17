// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/utils.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class Location extends StatelessWidget {
  const Location({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    String storeName = BlocProvider.of<TransactionBloc>(context).store!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location',
          style: theme.subheadBold,
        ),
        SizedBox(height: screenHeight * 0.015),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth * 0.071,
            ),
            Image.asset(
              getStoreNamePath(storeName),
              width: screenWidth * 0.1,
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storeName,
                  style: theme.caption1,
                ),
                const Text(
                  'SM Seaside Cebu',
                  style: theme.caption1,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
