// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:inquire_near/screens/inquirer/answer_inquiry/widgets/inquirer_proof.dart';

class InquirerBottomBar extends StatefulWidget {
  final Function(File) onIconSelected;
  final bool requireProof;
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
        try {
          widget.onIconSelected(File(file!.path));
        } catch (_) {}
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
          (widget.requireProof)
              ? const InquirerProof(
                  hasProof: false,
                  showWidget: true,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
