import 'package:flutter/material.dart';
import 'package:inquire_near/data/models/store_data.dart';
import 'package:inquire_near/screens/client/client_dashboard/widgets/search_bar.dart';
import 'package:inquire_near/screens/client/client_dashboard/widgets/store_container.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:inquire_near/constants.dart' as constants;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchTextController = TextEditingController();
  List<StoreData> stores = constants.stores;

  void searchStore(String query) {
    stores = constants.stores;
    final suggestions = stores.where((store) {
      final storeName = store.name.toLowerCase();
      final input = query.toLowerCase();

      return storeName.contains(input);
    }).toList();

    setState(() => stores = suggestions);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding,
          child: Column(
            children: [
              SearchBar(
                controller: searchTextController,
                onTap: () {},
                onChanged: searchStore,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: stores.length,
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
                                imageFilePath: stores[index].imageFileLocation,
                              ),
                              SizedBox(
                                width: screenWidth * 0.04,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    stores[index].name,
                                    style: theme.headline,
                                  ),
                                  Text(
                                    stores[index].category,
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
      ),
    );
  }
}
