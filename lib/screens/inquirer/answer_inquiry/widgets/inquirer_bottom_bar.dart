import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InquirerBottomBar extends StatefulWidget {
  final Function(File) onIconSelected;
  final ValueChanged<bool> requireProof;
  final bool? initialValue;
  const InquirerBottomBar(
      {Key? key,
      required this.onIconSelected,
      required this.requireProof,
      this.initialValue})
      : super(key: key);

  @override
  State<InquirerBottomBar> createState() => _InquirerBottomBarState();
}

class _InquirerBottomBarState extends State<InquirerBottomBar> {
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
    // bool? requireProof = widget.initialValue;
    // void updateBool(bool? value) {
    //   setState(() {
    //     widget.requireProof(value!);
    //     requireProof = value;
    //   });
    // }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey)),
          color: Colors.white),
      child: Row(
        children: [
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
