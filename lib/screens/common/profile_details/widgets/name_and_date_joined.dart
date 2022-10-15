import 'package:flutter/material.dart';
import 'package:inquire_near/data/models/in_user.dart';

import 'package:inquire_near/themes/app_theme.dart' as theme;

class NameAndDateJoined extends StatelessWidget {
  const NameAndDateJoined({
    Key? key,
    required this.user,
  }) : super(key: key);

  final INUser user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${user.firstName} ${user.lastName}",
          style: theme.headline,
        ),
        // TODO: Add actual data. Field 'datetimeCreated' TBD
        const Text(
          "Joined March 2022",
          style: theme.caption2,
        ),
      ],
    );
  }
}
