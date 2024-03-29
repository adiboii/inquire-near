// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:photo_view/photo_view.dart';

// Project imports:
import 'package:inquire_near/components/back_button.dart' as components;

class ImageViewer extends StatelessWidget {
  const ImageViewer({super.key, this.imageUrl, this.file});
  final String? imageUrl;
  final File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (imageUrl == null && file == null)
          ? const SizedBox()
          : Stack(
              children: [
                PhotoView(
                  minScale: PhotoViewComputedScale.contained,
                  imageProvider: ((file != null)
                      ? FileImage(file!)
                      : NetworkImage(imageUrl!)) as ImageProvider,
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
            ),
    );
  }
}
