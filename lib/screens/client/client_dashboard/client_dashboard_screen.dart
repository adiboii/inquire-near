// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/components/greeting.dart';
import 'package:inquire_near/components/switch_user_type.dart';
import 'package:inquire_near/constants.dart' as constants;
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/enums/role.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/screens/client/client_dashboard/category_screen.dart';
import 'package:inquire_near/screens/client/client_dashboard/widgets/recent_place.dart';
import 'package:inquire_near/screens/client/client_dashboard/widgets/search_bar.dart';
import 'package:inquire_near/screens/common/recent_transactions/recent_transactions_widget.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:move_to_background/move_to_background.dart';

class ClientDashboardScreen extends StatefulWidget {
  const ClientDashboardScreen({Key? key}) : super(key: key);

  @override
  State<ClientDashboardScreen> createState() => _ClientDashboardScreenState();
}

class _ClientDashboardScreenState extends State<ClientDashboardScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      INUser? user = BlocProvider.of<AuthBloc>(context).user;
      if (user != null &&
          (user.paypalAddress == null || user.paypalAddress == "")) {
        Navigator.of(context).pushNamed(paypalAccountRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = constants.categories;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async {
          MoveToBackground.moveTaskToBack();
          return false;
        },
        child: SafeArea(
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
                            Navigator.pushNamed(context, profileRoute);
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
                            Greeting(
                              name: BlocProvider.of<AuthBloc>(context)
                                  .user!
                                  .firstName!,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SwitchUserType(
                        screenHeight: screenHeight, currentRole: Role.client),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                SearchBar(
                  readOnly: true,
                  onTap: () {
                    Navigator.pushNamed(context, searchRoute);
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  "Categories",
                  style: theme.headline,
                ),
                SizedBox(height: screenHeight * 0.02),
                //TODO: convert to widget (MEL)
                SizedBox(
                  height: screenHeight * 0.04,
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: ((context, index) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryScreen(
                                    category: categories[index],
                                  ),
                                ),
                              );
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
                      "Featured Places",
                      style: theme.headline,
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    //TODO: convert to widget (MEL)
                    Row(
                      children: [
                        const Expanded(
                          child: FeaturedPlace(
                            storeName: 'BDO',
                            imageFilePath: 'assets/images/logos/bdo.png',
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        const Expanded(
                          child: FeaturedPlace(
                            storeName: 'H&M',
                            imageFilePath: 'assets/images/logos/h&m.png',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const RecentTransactions(role: Role.client),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
