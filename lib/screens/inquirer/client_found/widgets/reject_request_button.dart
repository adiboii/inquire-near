// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/inquirer/inquirer_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/enums/role.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class RejectRequestButton extends StatelessWidget {
  const RejectRequestButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ButtonOutline(
      label: 'Reject Request',
      style: theme.caption1Bold,
      height: screenHeight * 0.07,
      color: theme.red,
      textColor: theme.red,
      onTap: () {
        BlocProvider.of<TransactionBloc>(context).add(GetRecentTransaction(
            role: Role.inquirer,
            userId: BlocProvider.of<AuthBloc>(context).user!.uid!));

        BlocProvider.of<InquirerBloc>(context).add(RejectRequest());
        Navigator.of(context).pop();
      },
    );
  }
}
