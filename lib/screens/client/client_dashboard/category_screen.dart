import 'package:flutter/material.dart';
import 'package:inquire_near/screens/client/client_dashboard/widgets/store_container.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:inquire_near/constants.dart' as constants;

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
            Text(
              category!,
              style: theme.title2,
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
                          Navigator.pushNamed(context, '/inquiry_list');
                        },
                        child: Row(
                          children: [
                            StoreContainer(
                              imageFilePath:
                                  filteredStores[index].imageFileLocation,
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
