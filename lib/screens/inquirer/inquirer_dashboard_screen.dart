// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/inquirer/inquirer_bloc.dart';
import 'package:inquire_near/components/greeting.dart';
import 'package:inquire_near/components/status_switch.dart';
import 'package:inquire_near/components/switch_user_type.dart';
import 'package:inquire_near/components/wallet.dart';
import 'package:inquire_near/data/models/enums.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquirerDashboardScreen extends StatefulWidget {
  const InquirerDashboardScreen({super.key});

  @override
  State<InquirerDashboardScreen> createState() =>
      _InquirerDashboardScreenState();
}

class _InquirerDashboardScreenState extends State<InquirerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<InquirerBloc, InquirerState>(
          listenWhen: (context, state) {
            return state.isOnline ?? true;
          },
          listener: (context, state) {
            if (state is HiringRequestFound) {
              Navigator.of(context).pushNamed('/client_found');
            }

            if (state is AcceptedRequest) {
              Navigator.of(context).pushNamed('/reminders');
            }
          },
          buildWhen: (previous, current) {
            return previous.isOnline != current.isOnline;
          },
          builder: (context, state) {
            InquirerBloc inquirerBloc = BlocProvider.of<InquirerBloc>(context);

            // We add initial event here for status switch to work
            inquirerBloc.add(Initial());

            return Padding(
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
                          const Greeting(name: "Cymmer"),
                        ],
                      ),
                      SwitchUserType(
                          screenHeight: screenHeight, currentRole: Role.client),
                    ],
                  ),
                  StatusSwitch(
                    currentStatus: state.isOnline ?? false,
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
            );
          },
        ),
      ),
    );
  }
}
