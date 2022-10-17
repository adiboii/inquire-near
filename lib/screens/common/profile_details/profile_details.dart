// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/screens/common/profile_details/profile_details_utils.dart';
import 'package:inquire_near/screens/common/profile_details/widgets/cover_image.dart';
import 'package:inquire_near/screens/common/profile_details/widgets/name_and_date_joined.dart';
import 'package:inquire_near/screens/common/profile_details/widgets/profile_image.dart';
import 'package:inquire_near/screens/common/profile_details/widgets/reviews.dart';
import 'package:inquire_near/screens/common/profile_details/widgets/user_statistics.dart';

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
  ProfileDetailsUtils localUtils = ProfileDetailsUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: FutureBuilder(
            future: localUtils.getUserData(widget.userId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }

              Map<String, dynamic> data = snapshot.data;
              INUser user = data['user'];

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
                            NameAndDateJoined(user: user),
                            const Expanded(child: SizedBox.shrink()),
                            UserStatistics(data: data)
                          ],
                        )
                      ],
                    ),
                  ),
                  Reviews(data: data)
                ],
              );
            }),
      ),
    );
  }
}
