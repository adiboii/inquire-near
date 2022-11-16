import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: Center(child: Text("No Internet"))));
  }
}
