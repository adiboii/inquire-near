import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inquire_near/components/textfield.dart';
import 'package:inquire_near/components/wallet.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ClientDashboardScreen extends StatelessWidget {
  const ClientDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    final TextEditingController _search = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
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
                        radius: _width * 0.05,
                        backgroundImage: AssetImage(
                          'assets/images/illustrations/profile.png',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                SizedBox(
                  width: 40,
                ),
                SizedBox(
                  height: _height * 0.05,
                  width: _height * 0.05,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.primary,
                    ),
                  ),
                ),
              ],
            ),
            InTextField(
                icon: Icons.search,
                controller: _search,
                hint: "Search for places"),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "Categories",
                  style: theme.title3,
                ),
                SizedBox(height: 16),
                //TODO: convert to widget
                SizedBox(
                  height: _height * 0.02,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/inquiry_list');
                          },
                          child: Text("Popular")),
                      SizedBox(width: 12),
                      Text("Government"),
                      SizedBox(width: 12),
                      Text("Malls"),
                      SizedBox(width: 12),
                      Text("Grocery"),
                      SizedBox(width: 12),
                      Text("Lorem Ipsum"),
                      SizedBox(width: 12),
                      Text("Lorem Ipsum"),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "Your Card",
                  style: theme.title3,
                ),
                SizedBox(height: 16),
                Center(
                  child: Wallet(screenHeight: _height, screenWidth: _width),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "Recent Places",
                  style: theme.title3,
                ),
                SizedBox(height: 16),
                //TODO: convert to widget
                SizedBox(
                  height: _height * 0.22,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        width: 175,
                        decoration: BoxDecoration(
                          color: theme.gray,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: 175,
                        decoration: BoxDecoration(
                          color: theme.gray,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: 175,
                        decoration: BoxDecoration(
                          color: theme.gray,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: 175,
                        decoration: BoxDecoration(
                          color: theme.gray,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
