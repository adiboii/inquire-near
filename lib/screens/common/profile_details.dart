import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: ListView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
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
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 45,
                    child: CircleAvatar(
                      radius: 43,
                      backgroundImage:
                          AssetImage("assets/images/illustrations/profile.png"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                      SizedBox(width: width * 0.20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 12,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "4.5 (12 reviews)",
                                style: theme.caption2,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset("assets/images/svgs/task.svg"),
                              SizedBox(width: 4),
                              Text(
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
                  Text(
                    "Recent Reviews",
                    style: theme.callout_bold,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: height * 0.55,
                    child: ListView(
                      children: [
                        RecentReviewItem(width: width),
                        RecentReviewItem(width: width),
                        RecentReviewItem(width: width),
                        RecentReviewItem(width: width),
                        RecentReviewItem(width: width),
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
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: theme.primary,
                radius: 16,
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "c****r",
                    style: theme.caption1,
                  ),
                  Row(
                    children: [
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
                  Container(
                    width: width * 0.70,
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras scelerisque justo id sapien consectetur.",
                      style: theme.caption1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 12),
          Divider(),
        ],
      ),
    );
  }
}
