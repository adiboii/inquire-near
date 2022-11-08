// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:intl/intl.dart';

class NameAndDateJoined extends StatelessWidget {
  const NameAndDateJoined({
    Key? key,
    required this.user,
  }) : super(key: key);

  final INUser user;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MMMM y');
    final String monthAndYearJoined =
        formatter.format(user.dateTimeCreated.toDate());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${user.firstName} ${user.lastName}",
          style: theme.headline,
        ),
        Text(
          "Joined $monthAndYearJoined",
          style: theme.caption2,
        ),
      ],
    );
  }
}
