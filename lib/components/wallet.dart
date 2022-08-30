import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class Wallet extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const Wallet(
      {super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.80,
      height: screenHeight * 0.25,
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      decoration: const BoxDecoration(
        color: theme.primary,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cymmer Maranga",
                      style: theme.title3
                          .copyWith(color: Colors.white, fontSize: 12)),
                  Text(
                    "•••• •••• •••• 2457",
                    style: theme.title3.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Balance",
                      style: theme.title3.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                  Text(
                    "₱455.20",
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Colors.white, fontSize: 25),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
