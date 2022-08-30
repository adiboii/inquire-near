// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:image_picker/image_picker.dart';

class BottomBar extends StatefulWidget {
  final Function(File) onIconSelected;
  const BottomBar({Key? key, required this.onIconSelected}) : super(key: key);

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
        widget.onIconSelected(File(file!.path));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
