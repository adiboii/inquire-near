// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Project imports:
import 'package:inquire_near/components/pages.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

//import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding,
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = (index == 2);
              });
            },
            children: const [
              OnboardingPage(
                imageURL: "assets/images/illustrations/ChooseAPlace.png",
                title: "Choose a store",
                subtitle: "Easy access to stores in SM Seaside Cebu",
              ),
              OnboardingPage(
                imageURL: "assets/images/illustrations/AskQuestions.png",
                title: "Ask questions",
                subtitle:
                    "Connect and ask all the questions you need to know without going to the store.",
              ),
              OnboardingPage(
                imageURL: "assets/images/illustrations/EnjoyAsking.png",
                title: "Enjoy asking",
                subtitle:
                    "Know everything without leaving the comforts of your home.  ",
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, landingRoute);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                ),
                child: const Text("SKIP", style: theme.caption2Bold),
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotWidth: screenWidth * 0.03,
                  dotHeight: screenHeight * 0.015,
                  spacing: 16,
                  dotColor: Colors.black26,
                  activeDotColor: theme.primary,
                ),
                onDotClicked: (index) => controller.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut),
              ),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: theme.primary,
              ),
              child: IconButton(
                onPressed: () async {
                  if (isLastPage) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool("showOnboarding", false);
                    if (mounted) {
                      // if()
                      Navigator.pushReplacementNamed(context, landingRoute);
                    }
                  } else {
                    controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  }
                },
                icon: const Icon(
                  Icons.arrow_right,
                  size: 20,
                ),
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
