import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: const BoxDecoration(
                color: theme.primary,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1599173704879-2e407aa34cde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80"),
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0, -40, 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: screenWidth * 0.12,
                    child: CircleAvatar(
                      radius: screenWidth * 0.11,
                      backgroundImage: const AssetImage(
                          "assets/images/illustrations/profile.png"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Mel Gabutan",
                            style: theme.headline,
                          ),
                          Text(
                            "Joined March 2022",
                            style: theme.caption2,
                          ),
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 12,
                                color: Colors.amber,
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              const Text(
                                "4.5 (12 reviews)",
                                style: theme.caption2,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset("assets/images/svgs/task.svg"),
                              SizedBox(width: screenWidth * 0.01),
                              SizedBox(width: screenWidth * 0.01),
                              const Text(
                                "Has made 12 inquiries",
                                style: theme.caption2,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: theme.kScreenPadding.copyWith(top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recent Reviews",
                    style: theme.calloutBold,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  SizedBox(
                    height: screenHeight * 0.55,
                    child: ListView(
                      children: [
                        RecentReviewItem(width: screenWidth),
                        RecentReviewItem(width: screenWidth),
                        RecentReviewItem(width: screenWidth),
                        RecentReviewItem(width: screenWidth),
                        RecentReviewItem(width: screenWidth),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RecentReviewItem extends StatelessWidget {
  const RecentReviewItem({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: theme.primary,
                radius: 16,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "c****r",
                    style: theme.caption1,
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width * 0.70,
                    child: const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras scelerisque justo id sapien consectetur.",
                      style: theme.caption1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          const Divider(
            height: 0.9,
          ),
        ],
      ),
    );
  }
}
