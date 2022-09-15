// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InputField extends StatefulWidget {
  // Properties
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool isPassword;

  // Constructors
  const InputField({
    Key? key,
    required this.label,
    required this.controller,
    required this.icon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  // Properties
  bool? isObscured;
  // Methods
  @override
  void initState() {
    super.initState();
    isObscured = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          widget.label,
          style: theme.caption1,
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        TextFormField(
          onChanged: (value) {
            setState(() {});
          },
          controller: widget.controller,
          style: theme.callout,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            suffixIcon: (widget.controller.text.isNotEmpty)
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        if (widget.isPassword) {
                          isObscured = !isObscured!;
                        } else {
                          widget.controller.text = '';
                        }
                      });
                    },
                    icon: Icon(
                      (widget.isPassword == false)
                          ? Icons.close
                          : (isObscured!)
                              ? Icons.visibility_off
                              : Icons.visibility,
                    ),
                  )
                : null,
            prefixIcon: Icon(
              widget.icon,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.primary,
                width: 1,
              ),
            ),
          ),
          obscureText: isObscured!,
          validator: (val) => val!.isEmpty ? "Please enter your name" : null,
        ),
        SizedBox(
          height: screenHeight * 0.04,
        ),
      ],
    );
  }
}
