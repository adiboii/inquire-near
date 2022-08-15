import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InTextField extends StatelessWidget {
  String label;
  String hint;
  bool isObscure;
  IconData icon;
  TextEditingController controller;
  TextInputType type;
  InTextField(
      {this.label = '',
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
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
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
  String label;
  Icon? icon;
  String? value;
  bool isObscure;
  InTextFormField(
      {this.label = '', this.icon, this.value, this.isObscure = false});

  @override
  State<InTextFormField> createState() => _InTextFormFieldState();
}

class _InTextFormFieldState extends State<InTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.caption2,
        ),
        SizedBox(height: 4),
        TextFormField(
          // TODO: transfer to components
          style: theme.callout,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            prefixIcon: widget.icon,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.primary, width: 1)),
          ),
          obscureText: widget.isObscure,
          validator: (val) =>
              val!.isEmpty ? "Please enter your username" : null,
          onChanged: (val) {
            setState(() => widget.value = val);
          },
        ),
      ],
    );
  }
}
