import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    this.controller,
    required this.onTap,
  });
  final TextEditingController? controller;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: theme.secondary,
        ),
      ),
      child: TextField(
        onTap: () {
          onTap();
        },
        controller: controller,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: 'Search for a store',
        ),
      ),
    );
  }
}
