import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const InLabel(
      {super.key, required this.icon, required this.label, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 175,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 15),
            Text(label, style: theme.footnote),
          ],
        ),
      ),
    );
  }
}
