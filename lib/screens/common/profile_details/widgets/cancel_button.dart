// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/client/client_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: ButtonOutline(
        label: "Cancel",
        style: theme.caption1,
        color: theme.red,
        textColor: theme.red,
        onTap: () {
          BlocProvider.of<ClientBloc>(context).add(FindAvailableInquirers());
          Navigator.of(context).pop(false);
        },
      ),
    );
  }
}
