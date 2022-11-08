// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/enums/role.dart';
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
    String route;

    if (currentRole == Role.Client) {
      route = '/inquirer_dashboard';
    } else {
      route = '/client_dashboard';
    }

    return GestureDetector(
      onTap: () {
        BlocProvider.of<AuthBloc>(context).add(SwitchRole());
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
