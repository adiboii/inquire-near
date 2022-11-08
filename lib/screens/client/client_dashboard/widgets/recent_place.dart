// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class FeaturedPlace extends StatelessWidget {
  const FeaturedPlace({
    super.key,
    required this.storeName,
    required this.imageFilePath,
  });
  final String storeName;
  final String imageFilePath;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        BlocProvider.of<TransactionBloc>(context)
            .add(ClickStore(store: storeName));
        Navigator.pushNamed(context, '/inquiry_list');
      },
      child: Container(
        height: screenHeight * 0.2,
        width: screenHeight * 0.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(screenHeight * 0.007, screenHeight * 0.007),
            ),
          ],
        ),
        child: Padding(
          padding: theme.kCardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  child: Image.asset(imageFilePath),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                storeName,
                style: theme.footnoteBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
