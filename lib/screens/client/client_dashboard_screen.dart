import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:inquire_near/components/textfield.dart';
import 'package:inquire_near/components/wallet.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ClientDashboardScreen extends StatelessWidget {
  const ClientDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final TextEditingController search = TextEditingController();
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Padding(
          padding: theme.kScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: CircleAvatar(
                          radius: screenWidth * 0.05,
                          backgroundImage: const AssetImage(
                            'assets/images/illustrations/profile.png',
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Welcome back,",
                            style: theme.subhead,
                          ),
                          Text(
                            "John!",
                            style: theme.title2,
                          )
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/client_found');
                    },
                    child: SizedBox(
                      height: screenHeight * 0.05,
                      width: screenHeight * 0.05,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SvgPicture.asset(
                          "assets/images/svgs/change_user_type.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InTextField(
                  icon: Icons.search,
                  controller: search,
                  hint: "Search for places"),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.025),
                  const Text(
                    "Categories",
                    style: theme.title3,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  //TODO: convert to widget
                  SizedBox(
                    height: screenHeight * 0.02,
                    child: ListView(
                      //TODO: convert to listview.builder
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/inquiry_list');
                            },
                            child: const Text("Popular")),
                        SizedBox(width: screenWidth * 0.05),
                        const Text("Government"),
                        SizedBox(width: screenWidth * 0.05),
                        const Text("Malls"),
                        SizedBox(width: screenWidth * 0.05),
                        const Text("Grocery"),
                        SizedBox(width: screenWidth * 0.05),
                        const Text("Lorem Ipsum"),
                        SizedBox(width: screenWidth * 0.05),
                        const Text("Lorem Ipsum"),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.025),
                  const Text(
                    "Your Card",
                    style: theme.title3,
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  Center(
                    child: Wallet(
                        screenHeight: screenHeight, screenWidth: screenWidth),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.025),
                  const Text(
                    "Recent Places",
                    style: theme.title3,
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  //TODO: convert to widget
                  SizedBox(
                    height: screenHeight * 0.22,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          width: 175,
                          decoration: const BoxDecoration(
                            color: theme.gray,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Container(
                          width: 175,
                          decoration: const BoxDecoration(
                            color: theme.gray,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Container(
                          width: 175,
                          decoration: const BoxDecoration(
                            color: theme.gray,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Container(
                          width: 175,
                          decoration: const BoxDecoration(
                            color: theme.gray,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                      ],
                    ),
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
