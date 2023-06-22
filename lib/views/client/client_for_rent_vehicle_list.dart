import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/constants/firbase_constant.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';
import 'package:gocar/models/vehicle.dart';
import 'package:gocar/utils/helpers/asset.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/views/global/vehicle_details_screen.dart';
import 'package:gocar/views/rental/rental_create_record.dart';
import 'package:gocar/widgets/for_rent_car_card.dart';
import 'package:gocar/widgets/h.dart';
import 'package:gocar/widgets/loader_widget.dart';
import 'package:gocar/widgets/profile_widget.dart';
import 'package:heroicons/heroicons.dart';

class ClientForRentVehicleList extends StatelessWidget {
  void openEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'For Rent Cars',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // IconButton(
          //   onPressed: () => Get.to(() => RentalCreateRecord(),
          //       fullscreenDialog: true, transition: Transition.cupertino),
          //   icon: HeroIcon(
          //     HeroIcons.plus,
          //     style: HeroIconStyle.solid,
          //   ),
          // ),
          Builder(builder: (context) {
            return IconButton(
              onPressed: () => openEndDrawer(context),
              icon: ProfileWidget(),
            );
          }),
          SizedBox(width: 20),
        ],
      ),
      endDrawer: Drawer(
        child: GetBuilder<AuthController>(builder: (controller) {
          return ListView(
            children: [
              Container(
                height: 100,
                padding: EdgeInsets.all(10),
                child: Image.asset(Asset.image('gocar-colored.png')),
              ),
              SizedBox(height: 40),
              if (auth.currentUser != null)
                ListTile(
                  onTap: () => controller.logout(context),
                  title: Text('Logout'),
                  leading: Icon(Icons.logout),
                ),
            ],
          );
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SafeArea(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('vehicles')
                    .where('isSold', isEqualTo: false)
                    .where('status', isEqualTo: 'Approved')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return LoaderWidget();
                  } else {
                    final data = snapshot.data!;
                    final rentalVehicles = data.docs
                        .map((doc) =>
                            Vehicle.fromMap(doc.data() as Map<String, dynamic>))
                        .toList();

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: constraints.maxWidth / 300,
                      ),
                      itemCount: rentalVehicles.length,
                      itemBuilder: (context, index) {
                        final vehicle = rentalVehicles[index];

                        return GestureDetector(
                          onTap: () async {
                            Get.to(
                                () => VehicleDetailsScreen(
                                      vehicle: vehicle,
                                    ),
                                transition: Transition.cupertino);
                          },
                          child: ForRentCardWidget(vehicle: vehicle),
                        );
                      },
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
