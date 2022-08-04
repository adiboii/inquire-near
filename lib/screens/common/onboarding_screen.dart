import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inquire_near/components/pages.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = (index == 2);
            });
          },
          children: [
            OnboardingPage(
              imageURL: "assets/images/illustrations/ChooseAPlace.png",
              title: "Choose a place",
              subtitle:
                  "Easy access to far or popular locations you want to know.",
            ),
            OnboardingPage(
              imageURL: "assets/images/illustrations/AskQuestions.png",
              title: "Ask questions",
              subtitle:
                  "Connect and ask all the questions you need to know without going to the place. ",
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
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: TextButton(
                onPressed: () => controller.animateToPage(2,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                ),
                child: Text(
                  "SKIP",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  spacing: 16,
                  dotColor: Colors.black26,
                  activeDotColor: theme.primary,
                ),
                onDotClicked: (index) => controller.animateToPage(index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut),
              ),
            ),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: theme.primary,
              ),
              child: IconButton(
                onPressed: () async {
                  if (isLastPage) {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showHome', true);
                    Navigator.pushReplacementNamed(context, '/landing');
                  } else {
                    controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  }
                },
                icon: FaIcon(FontAwesomeIcons.angleRight),
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
