// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class Wallet extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String name;
  final double balance;

  const Wallet(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.name,
      required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.80,
      height: screenHeight * 0.30,
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: const BoxDecoration(
        color: theme.paypalBlue,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset("assets/images/logos/paypal.png",
                  height: screenHeight * 0.20)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Paypal",
                style: theme.headline.copyWith(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: theme.headline.copyWith(color: Colors.white)),
                      Text(
                        "•••• •••• •••• 2457",
                        style: theme.footnote.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Balance",
                          style: theme.footnote.copyWith(
                            color: Colors.white,
                          )),
                      Text(balance.toStringAsFixed(2),
                          style: theme.title2.copyWith(color: Colors.white)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
