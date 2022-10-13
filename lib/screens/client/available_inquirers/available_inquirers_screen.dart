// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/client/client_bloc.dart';
import 'package:inquire_near/screens/client/available_inquirers/widgets/available_inquirer.dart';
import 'package:inquire_near/screens/client/available_inquirers/widgets/cancel_button.dart';
import 'package:inquire_near/screens/client/available_inquirers/widgets/header.dart';
import 'package:inquire_near/screens/client/finding_inquirer_screen.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class AvailableInquirersScreen extends StatefulWidget {
  const AvailableInquirersScreen({Key? key}) : super(key: key);

  @override
  State<AvailableInquirersScreen> createState() =>
      _AvailableInquirersScreenState();
}

class _AvailableInquirersScreenState extends State<AvailableInquirersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClientBloc>(context).add(FindAvailableInquirers());
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: theme.kScreenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Header(screenHeight: screenHeight),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: BlocBuilder<ClientBloc, ClientState>(
                  builder: (context, state) {
                    if (state is NoAvailableInquirersFound) {
                      return const FindingInquirerScreen();
                    }

                    if (state is NewAvailableInquirersFound) {
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.inquirers.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // TODO: Show actual reviews of selected Inquirer
                              Navigator.pushNamed(context, '/profile_details');
                            },
                            child: AvailableInquirer(
                                inquirer: state.inquirers[index]),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: screenHeight * 0.02),
                      );
                    }

                    // Return Loading screen by default
                    return const FindingInquirerScreen();
                  },
                ),
              ),
            ),
            const CancelButton(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<ClientBloc>(context).add(StopFindAvailableInquirer());
  }
}
