// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    this.controller,
    required this.onTap,
    this.onChanged,
    this.readOnly = false,
  });
  final TextEditingController? controller;
  final Function onTap;
  final Function(String)? onChanged;
  final bool readOnly;
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
        autofocus: !readOnly,
        readOnly: readOnly,
        controller: controller,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: 'Search for a store',
        ),
        onChanged: onChanged,
      ),
    );
  }
}
