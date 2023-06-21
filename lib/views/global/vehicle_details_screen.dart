import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/widgets/car_details_card.dart';
import 'package:shimmer/shimmer.dart';

import 'package:gocar/models/vehicle.dart';
import 'package:gocar/utils/helpers/functions.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/views/global/full_screen_image_viewer.dart';
import 'package:gocar/widgets/v.dart';

class VehicleDetailsScreen extends StatelessWidget {
  Vehicle? vehicle;
  VehicleDetailsScreen({
    Key? key,
    this.vehicle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Title'),
      // ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              title: Text('Car Details'),
              expandedHeight: MediaQuery.of(context).size.height * 0.33,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Image.network(
                      vehicle!.cover_image as String,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Text(
                        'Your Text Here',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              floating: false,
              pinned: true,
              snap: false,
              // Add other properties and styling as needed
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CarDetailsCard(),
                        CarDetailsCard(),
                        CarDetailsCard(),
                        CarDetailsCard(),
                      ],
                    )

                    // Text(
                    //   capitalize('${vehicle?.model_name}'),
                    //   style: Theme.of(context).textTheme.headline1!.copyWith(
                    //         height: 0,
                    //         fontSize: 38,
                    //         color: AppColor.font,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    // ),
                    // const V(3),
                    // Text(
                    //   capitalize('Model'),
                    //   style: Theme.of(context).textTheme.headline1!.copyWith(
                    //         height: 0,
                    //         fontSize: 16,
                    //         color: AppColor.font,
                    //       ),
                    // ),
                    // const V(20),
                    // Text(
                    //   capitalize('${vehicle?.plate_number}'),
                    //   style: Theme.of(context).textTheme.headline1!.copyWith(
                    //         height: 0,
                    //         fontSize: 18,
                    //         color: AppColor.font,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    // ),
                    // const V(3),
                    // Text(
                    //   capitalize('Plate Number'),
                    //   style: Theme.of(context).textTheme.headline1!.copyWith(
                    //         height: 0,
                    //         fontSize: 16,
                    //         color: AppColor.font,
                    //       ),
                    // ),
                    // const V(20),
                    // Text(
                    //   capitalize('Car Images'),
                    //   style: Theme.of(context).textTheme.headline1!.copyWith(
                    //         height: 0,
                    //         fontSize: 18,
                    //         color: AppColor.font,
                    //       ),
                    // ),
                    // const V(20),
                    // SizedBox(
                    //   height: 300,
                    //   child: Stack(children: [
                    //     ListView.builder(
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: vehicle?.featured_image?.length ?? 0,
                    //       itemBuilder: (context, index) {
                    //         return GestureDetector(
                    //           onTap: () {
                    //             Get.to(() => FullScreenImageViewer(
                    //                 imageUrl:
                    //                     vehicle?.featured_image?[index]));
                    //           },
                    //           child: Padding(
                    //             padding: const EdgeInsets.only(right: 16.0),
                    //             child: CachedNetworkImage(
                    //               imageUrl: vehicle?.featured_image?[index]
                    //                   as String,
                    //               placeholder: (context, url) =>
                    //                   Shimmer.fromColors(
                    //                 baseColor: Colors.grey[300]!,
                    //                 highlightColor: Colors.grey[100]!,
                    //                 child: Container(
                    //                     decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(15),
                    //                   color: Colors.white,
                    //                 )),
                    //               ),
                    //               errorWidget: (context, url, error) =>
                    //                   Icon(Icons.error),
                    //               fit: BoxFit.cover,
                    //               width:
                    //                   MediaQuery.of(context).size.width / 1.2,
                    //               imageBuilder: (context, imageProvider) =>
                    //                   Container(
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(15),
                    //                   image: DecorationImage(
                    //                     image: imageProvider,
                    //                     fit: BoxFit.cover,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //     if (vehicle?.featured_image != null)
                    //       Positioned(
                    //           bottom: 10,
                    //           left: 10,
                    //           child: Container(
                    //             padding: EdgeInsets.all(8),
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(15),
                    //               color: Colors.black.withOpacity(0.8),
                    //             ),
                    //             child: Center(
                    //                 child: Text(
                    //               '${vehicle?.featured_image?.length ?? 0}',
                    //               style: TextStyle(
                    //                   color: Colors.white, fontSize: 16),
                    //             )),
                    //           )),
                    //   ]),
                    // ),
                    // const V(20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.13,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: const Center(
                    child: Text(
                      'Book Car Now',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
