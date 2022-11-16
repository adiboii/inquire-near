// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/inquirer/inquirer_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class AcceptRequestButton extends StatelessWidget {
  const AcceptRequestButton({
    Key? key,
    this.transaction,
  }) : super(key: key);

  final INTransaction? transaction;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ButtonFill(
      label: 'Accept Request',
      style: theme.caption1Bold,
      height: screenHeight * 0.07,
      onTap: () {
        BlocProvider.of<InquirerBloc>(context)
            .add(AcceptRequest(transaction!.id.toString()));
        Navigator.of(context).pushNamed(inquirerInquiryListRoute);
      },
    );
  }
}
