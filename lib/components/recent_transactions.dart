// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/components/list.dart';
import 'package:inquire_near/components/view_recent_transaction.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/enums/role.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class RecentTransactions extends StatefulWidget {
  final Role role;
  const RecentTransactions({super.key, required this.role});

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TransactionBloc>(context).add(GetRecentTransaction(
        role: widget.role,
        userId: BlocProvider.of<AuthBloc>(context).user!.uid!));
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    void viewTransaction(INTransaction transaction) async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => ViewTransactionScreen(
                    transaction: transaction,
                    role: widget.role,
                  ))));
    }

    return BlocConsumer<TransactionBloc, TransactionState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is TransactionLoading) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              AutoSizeText(
                'Recent Transactions',
                style: theme.headline,
              ),
              Center(child: CircularProgressIndicator()),
            ],
          );
        }

        if (state is RetrievedRecentTransactions) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AutoSizeText(
                'Recent Transactions',
                style: theme.headline,
              ),
              (state.recentTransactions.isEmpty)
                  ? const Center(child: Text("No Recent Transactions"))
                  : SizedBox(
                      height: (widget.role == Role.client)
                          ? screenHeight * 0.30
                          : screenHeight * 0.35,
                      width: screenWidth * 0.90,
                      child: ListView.builder(
                        itemCount: state.recentTransactions.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () async {
                              viewTransaction(state.recentTransactions[index]);
                            },
                            child: TransactionItem(
                              color: Colors.green,
                              store: state.recentTransactions[index].store,
                              date: state
                                  .recentTransactions[index].dateTimeEnded!,
                            ),
                          );
                        }),
                      ),
                    ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
