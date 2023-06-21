import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:gocar/models/vehicle.dart';
import 'package:gocar/utils/helpers/asset.dart';
import 'package:gocar/utils/helpers/functions.dart';
import 'package:shimmer/shimmer.dart';

class ForRentCardWidget extends StatelessWidget {
  
  Vehicle? vehicle;
   ForRentCardWidget({
    Key? key,
    this.vehicle,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: vehicle?.cover_image ?? sampleimage,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Positioned(
              child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          )),
          Positioned(
              top: 15,
              right: 10,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  capitalize('${vehicle?.model_name}'),
                  style: TextStyle(
                      height: 0,
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 34,
                width: 34,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                ),
                child: Icon(
                  Icons.star,
                  color: Colors.amber[300],
                  size: 24,
                ),
              )),
        ],
      ),
    );
  }
}
