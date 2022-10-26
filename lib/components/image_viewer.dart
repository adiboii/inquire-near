import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      minScale: PhotoViewComputedScale.contained,
      imageProvider: NetworkImage(imageUrl),
    );
  }
}
