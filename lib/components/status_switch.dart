// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:lottie/lottie.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/inquirer/inquirer_bloc.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class StatusSwitch extends StatefulWidget {
  final bool currentStatus;
  const StatusSwitch({
    Key? key,
    required this.currentStatus,
  }) : super(key: key);

  @override
  State<StatusSwitch> createState() => _StatusSwitchState();
}

class _StatusSwitchState extends State<StatusSwitch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InquirerBloc inquirerBloc = BlocProvider.of<InquirerBloc>(context);
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Status", style: theme.headline),
        FlutterSwitch(
            activeText: "Online",
            inactiveText: "Offline",
            activeColor: theme.primary,
            inactiveColor: theme.primaryGray,
            activeTextColor: Colors.white,
            inactiveTextColor: Colors.white,
            activeTextFontWeight: FontWeight.w700,
            inactiveTextFontWeight: FontWeight.w700,
            value: inquirerBloc.isOnline,
            valueFontSize: 15.0,
            width: 85,
            height: 30,
            borderRadius: 20.0,
            showOnOff: true,
            onToggle: (_) =>
                inquirerBloc.add(ToggleIsOnline(!inquirerBloc.isOnline))),
        SizedBox(height: screenHeight * 0.02),
        Lottie.asset("assets/images/lottie/job_search.json",
            height: screenHeight * 0.30),
        const Text(
          "Do not put your phone in silent mode\nas you wait for a client.",
          style: theme.footnote,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
