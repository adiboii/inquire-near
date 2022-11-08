import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inquire_near/components/back_button.dart' as components;
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({super.key, this.imageUrl, this.file});
  final String? imageUrl;
  final File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: imageUrl != null
          ? Stack(
              children: [
                PhotoView(
                  minScale: PhotoViewComputedScale.contained,
                  imageProvider: NetworkImage(imageUrl!),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white24,
                    ),
                    child: const components.INBackButton(
                        color: Colors.white, size: 25),
                  ),
                ),
              ],
            )
          : file != null
              ? Stack(
                  children: [
                    PhotoView(
                      minScale: PhotoViewComputedScale.contained,
                      imageProvider: FileImage(file!),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white24,
                        ),
                        child: const components.INBackButton(
                            color: Colors.white, size: 25),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
    );
  }
}
