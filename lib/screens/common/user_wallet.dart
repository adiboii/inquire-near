// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/list.dart';
import 'package:inquire_near/components/wallet.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class UserWalletScreen extends StatefulWidget {
  const UserWalletScreen({Key? key}) : super(key: key);

  @override
  State<UserWalletScreen> createState() => _UserWalletState();
}

class _UserWalletState extends State<UserWalletScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        //TODO:  use fontawesome
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: const Text(
          "Your Card",
          style: theme.title2,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding.copyWith(top: 0),
          child: Column(
            children: [
              Wallet(
                screenHeight: height,
                screenWidth: width,
                name: "Cymmer Maranga",
                balance: 445.20,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ButtonFill(
                    label: "Top-Up",
                    width: 170,
                    onTap: () {
                      Navigator.pushNamed(context, '/top_up');
                    },
                  ),
                  const SizedBox(width: 12),
                  const ButtonFill(
                    label: "Block Card",
                    width: 170,
                    color: theme.gray,
                    textColor: Colors.black,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent Transactions",
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: SizedBox(
                      height: height * 0.35,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: const [
                          InListItem(
                              color: Colors.red,
                              type: "Payment",
                              amount: "- ₱25.00"),
                          SizedBox(height: 12),
                          InListItem(
                              color: Colors.green,
                              type: "Top-up",
                              amount: "+ ₱150.00"),
                          SizedBox(height: 12),
                          InListItem(
                              color: Colors.red,
                              type: "Payment",
                              amount: "- ₱25.00"),
                          SizedBox(height: 12),
                          InListItem(
                              color: Colors.green,
                              type: "Top-up",
                              amount: "+ ₱150.00"),
                          SizedBox(height: 12),
                          InListItem(
                              color: Colors.red,
                              type: "Payment",
                              amount: "- ₱25.00"),
                          SizedBox(height: 10),
                          InListItem(
                              color: Colors.green,
                              type: "Top-up",
                              amount: "+ ₱150.00"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
