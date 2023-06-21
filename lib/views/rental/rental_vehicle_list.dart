import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/constants/firbase_constant.dart';
import 'package:gocar/controllers/rental/rental_controller.dart';
import 'package:gocar/models/vehicle.dart';
import 'package:gocar/utils/helpers/functions.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/views/rental/rental_create_record.dart';
import 'package:gocar/views/rental/rental_update_record.dart';
import 'package:gocar/views/rental/rental_vehicle_details.dart';
import 'package:gocar/widgets/h.dart';
import 'package:gocar/widgets/loader_widget.dart';
import 'package:gocar/widgets/rectangle_Image_widget.dart';
import 'package:gocar/widgets/v.dart';
import 'package:heroicons/heroicons.dart';

class RentalVehicleList extends StatefulWidget {
  const RentalVehicleList({Key? key}) : super(key: key);

  @override
  _RentalVehicleListState createState() => _RentalVehicleListState();
}

class _RentalVehicleListState extends State<RentalVehicleList> {
  final rentalController = Get.find<RentalController>();

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

                    return ListTile(
                  onTap: () => Get.to(() => RentalVehicleDetails(
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
                  subtitle: Text(vehicle.plate_number ?? ''),
                  trailing: PopupMenuButton(
                    surfaceTintColor: Colors.white,
                    onSelected: (value) {
                      switch (value) {
                        case 'update':

                          Get.to(()=> RentalUpdateRecord(vehicle: vehicle,));

                          return;
                        case 'delete':
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Delete'),
                                content: Text(
                                    'Are you sure you want to delete this item?'),
                                actions: [
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  GetBuilder<RentalController>(
                                      builder: (controller) {
                                    return ElevatedButton(
                                      child: controller.isDeleting.value
                                          ? LoaderWidget(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColor.primary, // set the background color of the button
                                      ),
                                      onPressed: () {
                                        rentalController.delete(
                                            context: context,
                                            id: vehicle.id as String);
                                      },
                                    );
                                  }),
                                ],
                              );
                            },
                          );
                          return;
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        value: 'update',
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 8),
                            Text('Update'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                    icon: Icon(Icons.more_vert),
                  ),
                );
              },
            );
             
          }
        },
      ),
    );
  }
}
