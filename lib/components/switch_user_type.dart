import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inquire_near/data/models/enums.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class SwitchUserType extends StatelessWidget {
  final Role currentRole;
  const SwitchUserType({
    Key? key,
    required this.screenHeight,
    required this.currentRole,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    String route = '/client_dashboard';

    if (currentRole == Role.inquirer) {
      route = '/inquirer_dashboard';
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
      },
      child: SizedBox(
        height: screenHeight * 0.05,
        width: screenHeight * 0.05,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            "assets/images/svgs/change_user_type.svg",
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
