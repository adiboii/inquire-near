import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/screens/client/client_dashboard/widgets/store_container.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:inquire_near/constants.dart' as constants;
import 'package:inquire_near/utils.dart' as utils;

import '../../../bloc/bloc/transaction/transaction_bloc.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({
    super.key,
    this.category,
  });
  final String? category;
  final stores = constants.stores;

  @override
  Widget build(BuildContext context) {
    final filteredStores =
        constants.stores.where((store) => store.category == category).toList();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: theme.kScreenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const BackButton(),
                Text(
                  category!,
                  style: theme.title2,
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredStores.length,
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<TransactionBloc>(context).add(
                              ClickStore(store: filteredStores[index].name));
                          Navigator.pushNamed(context, '/inquiry_list');
                        },
                        child: Row(
                          children: [
                            StoreContainer(
                              imageFilePath: utils
                                  .getStoreNamePath(filteredStores[index].name),
                            ),
                            SizedBox(
                              width: screenWidth * 0.04,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filteredStores[index].name,
                                  style: theme.headline,
                                ),
                                Text(
                                  filteredStores[index].category,
                                  style: theme.callout,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
