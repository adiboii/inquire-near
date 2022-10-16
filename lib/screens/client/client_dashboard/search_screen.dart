import 'package:flutter/material.dart';
import 'package:inquire_near/screens/client/client_dashboard/widgets/recent_place.dart';
import 'package:inquire_near/screens/client/client_dashboard/widgets/search_bar.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:inquire_near/constants.dart' as constants;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchTextController = TextEditingController();
  final stores = constants.stores;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding,
          child: Column(
            children: [
              SearchBar(
                controller: searchTextController,
                onTap: () {},
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: stores.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      leading: RecentPlace(
                        storeName: 'Casa Verde',
                        imageFilePath: 'assets/images/logos/Apple.png',
                      ),
                      title: Column(
                        children: [
                          Text(stores[index].name),
                          Text(stores[index].category),
                        ],
                      ),
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
