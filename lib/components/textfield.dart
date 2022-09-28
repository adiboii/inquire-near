// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isObscure;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType type;
  const InTextField(
      {super.key,
      this.label = '',
      this.isObscure = false,
      this.hint = '',
      this.type = TextInputType.text,
      required this.icon,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: theme.secondary,
              )),
          child: TextField(
            controller: controller,
            obscureText: isObscure,
            keyboardType: type,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              border: InputBorder.none,
              hintText: hint,
            ),
          ),
        ),
      ],
    );
  }
}

class InTextFormField extends StatefulWidget {
  final String label;
  final Icon? icon;
  final String value;
  final bool isObscure;
  const InTextFormField(
      {super.key,
      this.label = '',
      this.icon,
      required this.value,
      this.isObscure = false});

  @override
  State<InTextFormField> createState() => _InTextFormFieldState();
}

class _InTextFormFieldState extends State<InTextFormField> {
  String? formValue;
  late String textValue;

  @override
  void initState() {
    textValue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.caption2,
        ),
        const SizedBox(height: 4),
        TextFormField(
          // TODO: transfer to components
          style: theme.callout,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            prefixIcon: widget.icon,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: theme.primary, width: 1)),
          ),
          obscureText: widget.isObscure,
          validator: (val) =>
              val!.isEmpty ? "Please enter your username" : null,
          onChanged: (val) {
            setState(() => textValue = val);
          },
        ),
      ],
    );
  }
}
