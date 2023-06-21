import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/constants/firbase_constant.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';
import 'package:gocar/controllers/rental/rental_controller.dart';
import 'package:gocar/models/vehicle.dart';
import 'package:gocar/utils/helpers/asset.dart';
import 'package:gocar/utils/helpers/functions.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/views/global/vehicle_details_screen.dart';
import 'package:gocar/views/rental/rental_create_record.dart';
import 'package:gocar/views/rental/rental_update_record.dart';
import 'package:gocar/views/rental/rental_vehicle_details.dart';
import 'package:gocar/widgets/h.dart';
import 'package:gocar/widgets/loader_widget.dart';
import 'package:gocar/widgets/profile_widget.dart';
import 'package:gocar/widgets/rectangle_Image_widget.dart';
import 'package:gocar/widgets/v.dart';
import 'package:heroicons/heroicons.dart';

class AdminForRentVehicleList extends StatefulWidget {
  const AdminForRentVehicleList({Key? key}) : super(key: key);

  @override
  _AdminForRentVehicleListState createState() =>
      _AdminForRentVehicleListState();
}

class _AdminForRentVehicleListState extends State<AdminForRentVehicleList> {
  final rentalController = Get.find<RentalController>();

  void openEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'For Review',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => Get.to(() => RentalCreateRecord(),
                  fullscreenDialog: true, transition: Transition.cupertino),
              icon: HeroIcon(
                HeroIcons.plus,
                style: HeroIconStyle.solid,
              )),
          Builder(builder: (context) {
            return IconButton(
                onPressed: () => openEndDrawer(context), icon: ProfileWidget());
          }),
          H(
            20,
          ),
        ],
      ),

      endDrawer: Drawer(
        child: GetBuilder<AuthController>(builder: (controller) {
          return ListView(
            children: [
              Container(
                height: 100,
                // color: AppColor.primary,
                padding: EdgeInsets.all(10),
                child: Image.asset(Asset.image('gocar-colored.png')),
              ),
              H(40),
              if (auth.currentUser != null)
                ListTile(
                  onTap: () => controller.logout(context),
                  title: Text('Logout'),
                  leading: Icon(Icons.logout),
                )
            ],
          );
        }),
      ),
      // appBar: AppBar(
      //   title: Text(
      //     'Rental Cars',
      //     style: TextStyle(
      //       fontSize: 28,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () => Get.to(() => RentalCreateRecord(),
      //             fullscreenDialog: true, transition: Transition.cupertino),
      //         icon: HeroIcon(
      //           HeroIcons.plus,
      //           style: HeroIconStyle.solid,
      //         )),
      //     ProfileWidget(),
      //     H(
      //       30,
      //     ),
      //   ],
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('vehicles')
          .where('isSold', isEqualTo: false)
         .where('status', isEqualTo: 'Approved')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LoaderWidget(),
            );
          } else {
            final data = snapshot.data!;
            final rentalvehicles = data.docs
                .map((doc) =>
                    Vehicle.fromMap(doc.data() as Map<String, dynamic>))
                .toList();
            return ListView.builder(
              itemCount: rentalvehicles.length,
              itemBuilder: (context, index) {
                final vehicle = rentalvehicles[index];

                return ListTile(
                  onTap: () => Get.to(() => VehicleDetailsScreen(
                        vehicle: vehicle,
                      )),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  minVerticalPadding: 0.0,
                  leading: RectangleImageWidget(
                    url: vehicle.cover_image,
                    width: 50,
                    height: 200,
                    viewable: true,
                  ),
                  title: Text(capitalize('${vehicle.model_name}')),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      vehicle.status ?? '',
                      style: TextStyle(
                          color: vehicle.status == 'Approved'
                              ? Colors.green.shade600
                              : vehicle.status == 'For Review'
                                  ? Colors.blue.shade600
                                  : Colors.red.shade600),
                    ),
                  ),
                  // trailing: PopupMenuButton(
                  //   surfaceTintColor: Colors.white,
                  //   onSelected: (value) {
                  //     switch (value) {
                  //       case 'update':
                  //         showDialog(
                  //           context: context,
                  //           builder: (BuildContext context) {
                  //             return AlertDialog(
                  //               title: Text('Confirm Approve'),
                  //               content: Text(
                  //                   'Are you sure you want to approve this request ?'),
                  //               actions: [
                  //                 TextButton(
                  //                   child: Text('Cancel'),
                  //                   onPressed: () {
                  //                     Navigator.of(context).pop();
                  //                   },
                  //                 ),
                  //                 GetBuilder<RentalController>(
                  //                     builder: (controller) {
                  //                   return ElevatedButton(
                  //                     child: controller.isUpdating.value
                  //                         ? LoaderWidget(
                  //                             color: Colors.white,
                  //                           )
                  //                         : Text(
                  //                             'Approve',
                  //                             style: TextStyle(
                  //                                 color: Colors.white),
                  //                           ),
                  //                     style: ElevatedButton.styleFrom(
                  //                       primary: AppColor
                  //                           .primary, // set the background color of the button
                  //                     ),
                  //                     onPressed: () {
                  //                       rentalController.approveVehicles(
                  //                           context: context, vehicle: vehicle);
                  //                     },
                  //                   );
                  //                 }),
                  //               ],
                  //             );
                  //           },
                  //         );
                  //         return;
                  //       case 'delete':
                  //         showDialog(
                  //           context: context,
                  //           builder: (BuildContext context) {
                  //             return AlertDialog(
                  //               title: Text('Confirm Delete'),
                  //               content: Text(
                  //                   'Are you sure you want to delete this item?'),
                  //               actions: [
                  //                 TextButton(
                  //                   child: Text('Cancel'),
                  //                   onPressed: () {
                  //                     Navigator.of(context).pop();
                  //                   },
                  //                 ),
                  //                 GetBuilder<RentalController>(
                  //                     builder: (controller) {
                  //                   return ElevatedButton(
                  //                     child: controller.isDeleting.value
                  //                         ? LoaderWidget(
                  //                             color: Colors.white,
                  //                           )
                  //                         : Text(
                  //                             'Delete',
                  //                             style: TextStyle(
                  //                                 color: Colors.white),
                  //                           ),
                  //                     style: ElevatedButton.styleFrom(
                  //                       primary: AppColor
                  //                           .primary, // set the background color of the button
                  //                     ),
                  //                     onPressed: () {
                  //                       rentalController.delete(
                  //                           context: context,
                  //                           id: vehicle.id as String);
                  //                     },
                  //                   );
                  //                 }),
                  //               ],
                  //             );
                  //           },
                  //         );
                  //         return;
                  //     }
                  //   },
                  //   itemBuilder: (BuildContext context) => [
                  //     if (vehicle.status != 'Approved')
                  //       PopupMenuItem(
                  //         value: 'update',
                  //         child: Row(
                  //           children: [
                  //             Icon(Icons.edit),
                  //             SizedBox(width: 8),
                  //             Text('Aprrove'),
                  //           ],
                  //         ),
                  //       ),
                  //     // PopupMenuItem(
                  //     //   value: 'delete',
                  //     //   child: Row(
                  //     //     children: [
                  //     //       Icon(Icons.delete),
                  //     //       SizedBox(width: 8),
                  //     //       Text('Delete'),
                  //     //     ],
                  //     //   ),
                  //     // ),
                  //   ],
                  //   icon: Icon(Icons.more_vert),
                  // ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
