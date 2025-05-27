import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImagePage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: GestureDetector(
        // i was thinking to allow users to dragDown and exit the page.
        // onVerticalDragDown: (details) {
        //   Navigator.pop(context);
        // },
        child: Container(
          color: Colors.black,
          child: PhotoView(
            imageProvider: CachedNetworkImageProvider(imageUrl),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            loadingBuilder: (context, event) {
              if (event == null) return const Center(child: CircularProgressIndicator());
              final value = event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1);
              return Center(
                child: CircularProgressIndicator(value: value),
              );
            },
          ),
        ),
      ),
    );
  }
}
