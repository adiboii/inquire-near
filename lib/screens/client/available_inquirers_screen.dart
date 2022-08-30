// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/list.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class AvailableInquirersScreen extends StatefulWidget {
  const AvailableInquirersScreen({Key? key}) : super(key: key);

  @override
  State<AvailableInquirersScreen> createState() =>
      _AvailableInquirersScreenState();
}

class _AvailableInquirersScreenState extends State<AvailableInquirersScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Available Inquirers",
                    style: theme.headline,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  const Text(
                    "Once you hire an inquirer, the order cannot be cancelled.\nMake sure to finalize your inquiries before hiring.",
                    style: theme.caption1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    height: screenHeight * 0.65,
                    //TODO: convert to listview.builder
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/profile_details');
                          },
                          child: const AvailableInquirer(
                            name: "Mel Jefferson Gabutan",
                            rating: "4.5 (234 reviews)",
                            location: "Currently 0.9km away from location",
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        const AvailableInquirer(
                          name: "Fleurdelisse Rabanes",
                          rating: "4.5 (234 reviews)",
                          location: "Currently 0.9km away from location",
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        const AvailableInquirer(
                          name: "Cymmer John Maranga",
                          rating: "4.5 (234 reviews)",
                          location: "Currently 0.9km away from location",
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        const AvailableInquirer(
                          name: "Ada Pauline Villacarlos",
                          rating: "4.5 (234 reviews)",
                          location: "Currently 0.9km away from location",
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        const AvailableInquirer(
                          name: "Adrian Paul Reyes",
                          rating: "4.5 (234 reviews)",
                          location: "Currently 0.9km away from location",
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        const AvailableInquirer(
                          name: "William Shakespeare",
                          rating: "4.5 (234 reviews)",
                          location: "Currently 0.9km away from location",
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        const AvailableInquirer(
                          name: "William Shakespeare",
                          rating: "4.5 (234 reviews)",
                          location: "Currently 0.9km away from location",
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        const AvailableInquirer(
                          name: "William Shakespeare",
                          rating: "4.5 (234 reviews)",
                          location: "Currently 0.9km away from location",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ButtonOutline(
                  label: "Cancel",
                  style: theme.caption1,
                  color: theme.red,
                  textColor: theme.red,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
