import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class AddInquiryScreen extends StatefulWidget {
  AddInquiryScreen({Key? key}) : super(key: key);

  @override
  State<AddInquiryScreen> createState() => _AddInquiryScreenState();
}

class _AddInquiryScreenState extends State<AddInquiryScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //TODO: change to icon
                      Row(
                        children: [
                          SvgPicture.asset("assets/images/svgs/cancel.svg"),
                          SizedBox(width: 12),
                          SvgPicture.asset(
                              "assets/images/svgs/add_inquiry.svg"),
                          SizedBox(width: 12),
                          Text(
                            "Add an inquiry",
                            style: theme.headline,
                          ),
                        ],
                      ),

                      ButtonFill(
                        label: "Add inquiry",
                        width: width * 0.25,
                        height: height * 0.05,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: CircleAvatar(
                          radius: width * 0.05,
                          backgroundImage: AssetImage(
                            'assets/images/illustrations/profile.png',
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                      SizedBox(
                        width: width * 0.7,
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                              hintText: "What's happening?"),
                          style: theme.subhead,
                          maxLength: 150,
                          maxLines: null,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/images/svgs/image.svg"),
                      SizedBox(width: 12),
                      Text(
                        "Upload picture",
                        style: theme.body.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {
                          value = value;
                        },
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Require Proof",
                        style: theme.body.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
