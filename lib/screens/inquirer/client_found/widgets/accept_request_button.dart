import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/bloc/bloc/inquirer/inquirer_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class AcceptRequestButton extends StatelessWidget {
  const AcceptRequestButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ButtonFill(
      label: 'Accept Request',
      style: theme.caption1Bold,
      height: screenHeight * 0.07,
      onTap: () {
        BlocProvider.of<InquirerBloc>(context).add(AcceptRequest());
        Navigator.of(context).pop();
      },
    );
  }
}
