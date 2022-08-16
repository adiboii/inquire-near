import 'package:flutter/material.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/textfield.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class TopUpScreen extends StatelessWidget {
  final TextEditingController _TopUpScreenValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        //TODO: use fontawesome
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: Text(
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
                    SizedBox(
                      height: 50,
                      width: 10,
                      child: ColoredBox(color: theme.primary),
                    ),
                    SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Current Balance", style: theme.subhead),
                        Text("₱455.20", style: theme.title2),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 48),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter amount you wish\nto add to your wallet",
                      style: theme.title3,
                    ),
                    InTextField(
                      icon: Icons.php_outlined,
                      controller: _TopUpScreenValue,
                      hint: "0.00",
                      type: TextInputType.number,
                    ),
                    SizedBox(height: 28),
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
