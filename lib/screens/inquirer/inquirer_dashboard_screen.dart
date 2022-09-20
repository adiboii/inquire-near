import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:inquire_near/components/wallet.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:lottie/lottie.dart';

class InquirerDashboardScreen extends StatefulWidget {
  const InquirerDashboardScreen({super.key});

  @override
  State<InquirerDashboardScreen> createState() =>
      _InquirerDashboardScreenState();
}

class _InquirerDashboardScreenState extends State<InquirerDashboardScreen> {
  bool isOnline = true;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding.copyWith(top: 10),
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
                            style: theme.title3,
                          )
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/client_dashboard');
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Status", style: theme.headline),
                  FlutterSwitch(
                    activeText: "Online",
                    inactiveText: "Offline",
                    activeColor: theme.primary,
                    inactiveColor: theme.primaryGray,
                    activeTextColor: Colors.white,
                    inactiveTextColor: Colors.white,
                    activeTextFontWeight: FontWeight.w700,
                    inactiveTextFontWeight: FontWeight.w700,
                    value: isOnline,
                    valueFontSize: 15.0,
                    width: 85,
                    height: 30,
                    borderRadius: 20.0,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        isOnline = val;
                      });
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Lottie.asset("assets/images/lottie/job_search.json",
                      height: screenHeight * 0.30),
                  const Text(
                    "Do not put your phone in silent mode\nas you wait for a client.",
                    style: theme.footnote,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              const Text(
                "Your Card",
                style: theme.title3,
              ),
              SizedBox(height: screenHeight * 0.01),
              Center(
                child: Wallet(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  name: "Cymmer Maranga",
                  balance: 445.20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
