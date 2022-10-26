// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:inquire_near/components/image_viewer.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: imageUrl == null
          ? Container()
          : InkWell(
              // onTap: () => showDialog(
              //     builder: (BuildContext context) => AlertDialog(
              //           backgroundColor: Colors.transparent,
              //           insetPadding: EdgeInsets.all(2),
              //           title: Container(
              //             height: screenHeight * 0.75,
              //             decoration: BoxDecoration(),
              //             width: MediaQuery.of(context).size.width,
              //             child: Expanded(
              //               child: InteractiveViewer(
              //                 child: Image.network(
              //                   imageUrl!,
              //                   fit: BoxFit.contain,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //     context: context),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>
                          ImageViewer(imageUrl: imageUrl!)))),
              child: InteractiveViewer(
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
            ),
    );
  }
}
