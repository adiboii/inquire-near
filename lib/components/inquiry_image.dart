// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:inquire_near/components/image_viewer.dart';

class InquiryImage extends StatelessWidget {
  final File? image;
  final String? imageUrl;
  final VoidCallback? onCrossIconPressed;
  const InquiryImage(
      {super.key, this.onCrossIconPressed, this.image, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: image == null && imageUrl == null
          ? Container()
          : InkWell(
              onTap: () {
                if (image != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageViewer(file: image)));
                } else if (imageUrl != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ImageViewer(imageUrl: imageUrl)));
                }
              },
              child: Stack(
                children: [
                  InteractiveViewer(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 220,
                        width: MediaQuery.of(context).size.width * .8,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                            image: image != null
                                ? FileImage(image!)
                                : NetworkImage(imageUrl!) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black54),
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        iconSize: 20,
                        onPressed: onCrossIconPressed,
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
