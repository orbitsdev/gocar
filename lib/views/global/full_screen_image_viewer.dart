

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gocar/utils/helpers/asset.dart';

class FullScreenImageViewer extends StatelessWidget {
   String? imageUrl;
   FullScreenImageViewer({
    Key? key,
    this.imageUrl,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.black,
          child: Center(
            child: InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: imageUrl ?? sampleimage,
                fit: BoxFit.contain,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ),
      ),
    );
  }
}