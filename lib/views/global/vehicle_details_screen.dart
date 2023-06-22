import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';
import 'package:gocar/widgets/car_details_card.dart';
import 'package:gocar/widgets/h.dart';
import 'package:heroicons/heroicons.dart';
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
    final authcontroller = Get.find<AuthController>();
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
              centerTitle: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.33,
              flexibleSpace: FlexibleSpaceBar(
                background: GestureDetector(
                  onTap: () {
                    Get.to(() => FullScreenImageViewer(
                        imageUrl: vehicle?.cover_image as String));
                  },
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 70),
                        child: CachedNetworkImage(
                          imageUrl: vehicle!.cover_image as String,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                          placeholder: (BuildContext context, String url) =>
                              Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.white,
                            ),
                          ),
                          errorWidget: (BuildContext context, String url,
                                  dynamic error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                          top: 70,
                          right: 0,
                          left: 0,
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.3),
                                  Colors.black.withOpacity(0.8),
                                ],
                              ),
                            ),
                          )),
                      Positioned(
                        top: 80,
                        left: 20,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Text(
                            capitalize('${vehicle?.model_name}'),
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const V(20),

                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(8),
                      //         color: vehicle?.isSold == false
                      //             ? Colors.green.withOpacity(0.2)
                      //             : Colors.red.withOpacity(0.2),
                      //       ),
                      //       padding: EdgeInsets.symmetric(
                      //           horizontal: 10, vertical: 5),
                      //       child: Text(
                      //         capitalize(
                      //             '${vehicle?.isSold == false ? 'Available' : 'Not Available'}'),
                      //         style: TextStyle(
                      //           fontSize: 14,
                      //           color: vehicle?.isSold == false
                      //               ? Colors.green
                      //               : Colors.red,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      if (authcontroller.user.value.role != 'Client')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const H(10),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: vehicle?.status == 'Approved'
                                    ? Colors.green.withOpacity(0.2)
                                    : vehicle?.status == 'For Review'
                                        ? Colors.blue.withOpacity(0.2)
                                        : Colors.red.withOpacity(0.2),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                children: [
                                  HeroIcon(
                                    vehicle?.status == 'Approved'
                                        ? HeroIcons.check
                                        : vehicle?.status == 'For Review'
                                            ? HeroIcons.clock
                                            : HeroIcons.xMark,
                                    style: HeroIconStyle.outline,
                                    color: vehicle?.status == 'Approved'
                                        ? Colors.green
                                        : vehicle?.status == 'For Review'
                                            ? Colors.blue
                                            : Colors.red,
                                    size: 20,
                                  ),
                                  H(5),
                                  Text(
                                    capitalize('${vehicle?.status}'),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: vehicle?.status == 'Approved'
                                          ? Colors.green
                                          : vehicle?.status == 'For Review'
                                              ? Colors.blue
                                              : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ]),
                    // add details for if available or not

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Plate Number',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600)),
                                    const V(5),
                                    Text(
                                      '${vehicle!.plate_number}'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.font),
                                    ),
                                  ],
                                ),
                              ),
                              V(10),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Model',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600)),
                                    // Text('Php ${vehicle!.price}' ,style:TextStyle(fontSize: 24, fontWeight: FontWeight.bold,  color: AppColor.primary)),
                                    const V(5),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "${vehicle!.model_name}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.font),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const H(10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Transmission',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600)),
                                    // Text('Php ${vehicle!.price}' ,style:TextStyle(fontSize: 24, fontWeight: FontWeight.bold,  color: AppColor.primary)),
                                    const V(5),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: "Automatic",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.font),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              V(10),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Price',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600)),
                                    // Text('Php ${vehicle!.price}' ,style:TextStyle(fontSize: 24, fontWeight: FontWeight.bold,  color: AppColor.primary)),
                                    const V(5),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: "₱ ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.font),
                                          ),
                                          TextSpan(
                                              text: "${vehicle!.price}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.font)),
                                          TextSpan(
                                              text: " / day",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey.shade600)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Add more children as needed
                      ],
                    ),
                    //featured Image
                    const V(20),
                    Text(
                      capitalize('Car Images'),
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            height: 0,
                            fontSize: 18,
                            color: AppColor.font,
                          ),
                    ),
                    const V(20),
                    SizedBox(
                      height: 300,
                      child: Stack(children: [
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: vehicle?.featured_image?.length ?? 0,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => FullScreenImageViewer(
                                    imageUrl: vehicle?.featured_image?[index]));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      vehicle?.featured_image?[index] as String,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                        decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    )),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        if (vehicle?.featured_image != null)
                          Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black.withOpacity(0.8),
                                ),
                                child: Center(
                                    child: Text(
                                  '${vehicle?.featured_image?.length ?? 0}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )),
                              )),
                      ]),
                    ),
                    V(MediaQuery.of(context).size.height * 0.20),
                    // SizedBox(
                    //   height: 300,
                    //   child: GridView.count(
                    //     physics: NeverScrollableScrollPhysics(),
                    //     crossAxisCount: 2,
                    //     crossAxisSpacing: 8,
                    //     children: [
                    //       // Grid items go here
                    //       // Example grid item

                    //       // Example grid item

                    //       // Add more grid items as needed
                    //     ],
                    //   ),
                    // )

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     CarDetailsCard(),
                    //     CarDetailsCard(),
                    //     CarDetailsCard(),
                    //     // CarDetailsCard(),
                    //   ],
                    // ),
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
      bottomSheet: authcontroller.user.value.role != 'Client'
          ? null
          : Container(
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
                        onPressed: () {
                          //show aler dialog for confirmation use material dialog
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Confirmation'),
                                  content: Text(
                                      'Are you sure you want to book this car? / Please note no function yet'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('Cancel')),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.green.shade500,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('Confirm')),
                                  ],
                                );
                              });
                        },
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
