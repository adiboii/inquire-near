// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class BottomBar extends StatefulWidget {
  final Function(File) onIconSelected;
  final ValueChanged<bool> requireProof;
  final bool? initialValue;
  const BottomBar(
      {Key? key,
      required this.onIconSelected,
      required this.requireProof,
      this.initialValue})
      : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  void setImage(ImageSource source) {
    ImagePicker()
        .pickImage(source: source, imageQuality: 20)
        .then((XFile? file) {
      setState(() {
        // _image = file;
        try {
          widget.onIconSelected(File(file!.path));
        // ignore: empty_catches
        } catch (e) {}
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool? requireProof = widget.initialValue;
    void updateBool(bool? value) {
      setState(() {
        widget.requireProof(value!);
        requireProof = value;
      });
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              setImage(ImageSource.gallery);
            },
            icon: const Icon(Icons.image),
          ),
          IconButton(
            onPressed: () {
              setImage(ImageSource.camera);
            },
            icon: const Icon(Icons.camera_alt_sharp),
          ),
          Checkbox(
            value: requireProof,
            onChanged: updateBool,
          ),
          const Text(
            "Require Proof",
            style: theme.subhead,
          )
        ],
      ),
    );
  }
}
