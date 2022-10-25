// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

class InquiryImage extends StatelessWidget {
  final File? image;

  final VoidCallback? onCrossIconPressed;
  const InquiryImage({super.key, this.onCrossIconPressed, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: image == null
          ? Container()
          : Stack(
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
                          image: FileImage(image!),
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
    );
  }
}

class ClientInquiryImage extends StatelessWidget {
  final String? imageUrl;

  const ClientInquiryImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: imageUrl == null
          ? Container()
          : InteractiveViewer(
              child: Container(
                alignment: Alignment.topRight,
                child: Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width * .8,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
