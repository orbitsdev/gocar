import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/constants/firbase_constant.dart';
import 'package:gocar/models/vehicle.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/views/rental/rental_create_record.dart';
import 'package:gocar/views/rental/rental_vehicle_details.dart';
import 'package:gocar/widgets/h.dart';
import 'package:gocar/widgets/loader_widget.dart';
import 'package:gocar/widgets/v.dart';
import 'package:heroicons/heroicons.dart';

class RentalVehicleList extends StatefulWidget {
  const RentalVehicleList({Key? key}) : super(key: key);

  @override
  _RentalVehicleListState createState() => _RentalVehicleListState();
}

class _RentalVehicleListState extends State<RentalVehicleList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehcile List'),
        actions: [
          IconButton(
              onPressed: () => Get.to(() => RentalCreateRecord(), fullscreenDialog: true, transition: Transition.cupertino),
              icon: HeroIcon(
                HeroIcons.plus,
                style: HeroIconStyle.solid,
              )),
          V(20),
        ],
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('vehicles').where('uid', isEqualTo: auth.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LoaderWidget(),
            );
          } else {
            final data = snapshot.data!;
            final rentalvehicles = data.docs.map((doc) =>  Vehicle.fromMap(doc.data() as Map<String, dynamic>)).toList();
            return ListView.builder(
              itemCount: rentalvehicles.length,
              itemBuilder: (context, index) {
                final vehicle = rentalvehicles[index];

               return GestureDetector(
                  onTap: ()=> RentalVehicleDetails(vehicle: vehicle,),
                 child: Container(
                      margin: const EdgeInsets.only(bottom: 1),
                      constraints: const BoxConstraints(minHeight: 70),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: AppColor.borderLight, width: 1.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                Container(
                                  height: 54,
                                  width: 54,
                                  decoration: BoxDecoration(
                                    color: AppColor.purple1.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(15),
                                    // border: Border.all(
                                    //     width: 1, color: AppColor.greyBackground),
                                  ),
                                  child: Center(
                                    child: HeroIcon(
                                      HeroIcons.user,
                                      style: HeroIconStyle.solid,
                                      color: AppColor.purple1,
                                      size: 28,
                                    ),
                                  ),
                                ),
                                const H(16),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${vehicle.model_name}',
                                        style: TextStyle(
                                          height: 1.2,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      V(2),
                                      Text(
                                        'Tin - ${vehicle.plate_number ?? 'None'}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColor.purple1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: HeroIcon(
                                HeroIcons.chevronRight,
                                style: HeroIconStyle.solid,
                                size: 22,
                                color: AppColor.purple1,
                              ))
                        ],
                      ),
                    ),
               );
                // return ListTile(
                //   onTap: () => Get.to(() => RentalVehicleDetails(
                //         vehicle: vehicle,
                //       )),
                //   contentPadding:
                //       EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                //   minVerticalPadding: 0.0,
                //   leading: RectangleImageWidget(
                //     url: spot.cover_image,
                //     width: 50,
                //     height: 200,
                //     viewable: true,
                //   ),
                //   title: Text(capitalize('${spot.name}')),
                //   subtitle: Text(spot.formatted_address ?? ''),
                //   trailing: PopupMenuButton(
                //     surfaceTintColor: Colors.white,
                //     onSelected: (value) {
                //       switch (value) {
                //         case 'update':

                //           Get.to(()=> UpdateTouristSpotScreen(touristspot:spot,));

                //           return;
                //         case 'delete':
                //           showDialog(
                //             context: context,
                //             builder: (BuildContext context) {
                //               return AlertDialog(
                //                 title: Text('Confirm Delete'),
                //                 content: Text(
                //                     'Are you sure you want to delete this item?'),
                //                 actions: [
                //                   TextButton(
                //                     child: Text('Cancel'),
                //                     onPressed: () {
                //                       Navigator.of(context).pop();
                //                     },
                //                   ),
                //                   GetBuilder<TouristSpotController>(
                //                       builder: (controller) {
                //                     return ElevatedButton(
                //                       child: controller.isDeleting.value
                //                           ? LoaderWidget(
                //                               color: Colors.white,
                //                             )
                //                           : Text(
                //                               'Delete',
                //                               style: TextStyle(
                //                                   color: Colors.white),
                //                             ),
                //                       style: ElevatedButton.styleFrom(
                //                         primary: AppTheme
                //                             .ORANGE, // set the background color of the button
                //                       ),
                //                       onPressed: () {
                //                         touristcontroller.deleteTouristSpot(
                //                             context: context,
                //                             id: spot.id as String);
                //                       },
                //                     );
                //                   }),
                //                 ],
                //               );
                //             },
                //           );
                //           return;
                //       }
                //     },
                //     itemBuilder: (BuildContext context) => [
                //       PopupMenuItem(
                //         value: 'update',
                //         child: Row(
                //           children: [
                //             Icon(Icons.edit),
                //             SizedBox(width: 8),
                //             Text('Update'),
                //           ],
                //         ),
                //       ),
                //       PopupMenuItem(
                //         value: 'delete',
                //         child: Row(
                //           children: [
                //             Icon(Icons.delete),
                //             SizedBox(width: 8),
                //             Text('Delete'),
                //           ],
                //         ),
                //       ),
                //     ],
                //     icon: Icon(Icons.more_vert),
                //   ),
                // );
              },
            );
          }
        },
      ),
    );
  }
}
