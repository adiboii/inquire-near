import 'package:flutter/material.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/textfield.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class TopUp extends StatelessWidget {
  final TextEditingController _topUpValue = TextEditingController();

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
          style: theme.header2,
        ),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(35, 40, 35, 0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 10,
                    child: ColoredBox(color: theme.primary),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Current Balance", style: theme.header4),
                      Text("₱455.20", style: theme.header2),
                    ],
                  )
                ],
              ),
              SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter amount you wish\nto add to your wallet",
                    style: theme.header3,
                  ),
                  InTextField(
                    icon: Icons.php_outlined,
                    controller: _topUpValue,
                    hint: "0.00",
                    type: TextInputType.number,
                  ),
                  SizedBox(height: 30),
                  ButtonFill(
                    label: "Confirm",
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ) //end,
          ),
    );
  }
}
