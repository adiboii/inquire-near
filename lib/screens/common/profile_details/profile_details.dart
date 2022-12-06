// Flutter imports:
import 'dart:async';

import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/client/client_bloc.dart';
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/screens/common/profile_details/widgets/cancel_button.dart';
import 'package:inquire_near/screens/common/profile_details/widgets/cover_image.dart';
import 'package:inquire_near/screens/common/profile_details/widgets/hire_button.dart';
import 'package:inquire_near/screens/common/profile_details/widgets/name_and_date_joined.dart';
import 'package:inquire_near/screens/common/profile_details/widgets/profile_image.dart';
import 'package:inquire_near/screens/common/profile_details/widgets/reviews.dart';
import 'package:inquire_near/screens/common/profile_details/widgets/user_statistics.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ProfileDetailsScreen extends StatefulWidget {
  final String userId;
  final bool isHiring;
  const ProfileDetailsScreen(
      {Key? key, required this.userId, required this.isHiring})
      : super(key: key);

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  late Timer checkInquirerStillActive;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ClientBloc>(context).add(GetInquirerDetails(widget.userId));

    checkInquirerStillActive =
        Timer.periodic(const Duration(seconds: 1), (timer) {
      ClientBloc clientBloc = BlocProvider.of<ClientBloc>(context);
      List<INUser> inquirers = clientBloc.inquirers;

      // Check if userId still in inquirers list. If not, go back to available inquirers screen
      Iterable filteredInquirers =
          inquirers.where((inquirer) => inquirer.uid == widget.userId);
      if (filteredInquirers.isEmpty) {
        Navigator.of(context).pop();
        clientBloc.add(FindAvailableInquirers());
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    checkInquirerStillActive.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: theme.primary,
          )),
      body: SafeArea(
        child: BlocBuilder<ClientBloc, ClientState>(builder: (context, state) {
          if (state is ClientLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is RetrievedInquirerDetails) {
            return Column(
              children: [
                const CoverImage(),
                Container(
                  transform: Matrix4.translationValues(0, -40, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ProfileImage(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          NameAndDateJoined(user: state.data["user"]),
                          const Expanded(child: SizedBox.shrink()),
                          UserStatistics(data: state.data)
                        ],
                      )
                    ],
                  ),
                ),
                Reviews(data: state.data),
                const Expanded(child: SizedBox.shrink()),
                widget.isHiring
                    ? Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: HireButton(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: CancelButton(),
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
