// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_switch/flutter_switch.dart';
import 'package:lottie/lottie.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class StatusSwitch extends StatefulWidget {
  const StatusSwitch({
    Key? key,
    required this.isOnline,
    required this.screenHeight,
  }) : super(key: key);

  final bool isOnline;
  final double screenHeight;

  @override
  State<StatusSwitch> createState() => _StatusSwitchState();
}

class _StatusSwitchState extends State<StatusSwitch> {
  late bool isOnline;

  @override
  void initState() {
    super.initState();
    isOnline = widget.isOnline;
  }

  @override
  Widget build(BuildContext context) {
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
          value: isOnline,
          valueFontSize: 15.0,
          width: 85,
          height: 30,
          borderRadius: 20.0,
          showOnOff: true,
          onToggle: (val) {
            setState(() {
              isOnline = val;
              log(isOnline.toString());
            });
          },
        ),
        SizedBox(height: widget.screenHeight * 0.02),
        Lottie.asset("assets/images/lottie/job_search.json",
            height: widget.screenHeight * 0.30),
        const Text(
          "Do not put your phone in silent mode\nas you wait for a client.",
          style: theme.footnote,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
