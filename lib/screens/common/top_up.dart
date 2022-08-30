import 'package:flutter/material.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/textfield.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class TopUpScreen extends StatelessWidget {
  final TextEditingController topUpScreenValue = TextEditingController();

  TopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        //TODO: use fontawesome
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: const Text(
          "Top-Up",
          style: theme.title2,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
            padding: theme.kScreenPadding,
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      height: 50,
                      width: 10,
                      child: ColoredBox(color: theme.primary),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Current Balance", style: theme.subhead),
                        Text("₱455.20", style: theme.title2),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 48),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Enter amount you wish\nto add to your wallet",
                      style: theme.title3,
                    ),
                    InTextField(
                      icon: Icons.php_outlined,
                      controller: topUpScreenValue,
                      hint: "0.00",
                      type: TextInputType.number,
                    ),
                    const SizedBox(height: 28),
                    ButtonFill(
                      label: "Confirm",
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ) //end,
            ),
      ),
    );
  }
}
