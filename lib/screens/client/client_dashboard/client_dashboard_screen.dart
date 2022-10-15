// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import 'package:inquire_near/components/switch_user_type.dart';
import 'package:inquire_near/components/textfield.dart';
import 'package:inquire_near/data/models/enums.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:inquire_near/constants.dart' as constants;

class ClientDashboardScreen extends StatelessWidget {
  const ClientDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = constants.categories;
    final user = FirebaseAuth.instance.currentUser!;
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
                        children: [
                          const Text(
                            "Welcome back,",
                            style: theme.subhead,
                          ),
                          Text(
                            "${user.email}",
                            style: theme.title3,
                          )
                        ],
                      ),
                    ],
                  ),
                  SwitchUserType(
                      screenHeight: screenHeight, currentRole: Role.inquirer),
                ],
              ),
              InTextField(
                  icon: Icons.search,
                  controller: search,
                  hint: "Search for places"),
              SizedBox(height: screenHeight * 0.01),
              const Text(
                "Categories",
                style: theme.title3,
              ),
              SizedBox(height: screenHeight * 0.01),
              //TODO: convert to widget
              SizedBox(
                height: screenHeight * 0.04,
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: ((context, index) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/inquiry_list');
                          },
                          child: Text(
                            categories[index],
                            style: theme.callout,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.04,
                        ),
                      ],
                    );
                  }),
                  scrollDirection: Axis.horizontal,
                ),
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
                    height: screenHeight * 0.20,
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
