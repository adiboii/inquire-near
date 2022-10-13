// Flutter imports:
import 'package:flutter/material.dart';

class NoAvailableInquirers extends StatelessWidget {
  const NoAvailableInquirers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("No available Inquirers. Try again later."),
      ],
    ));
  }
}
