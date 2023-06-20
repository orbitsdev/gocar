import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/views/rental/rental_create_record.dart';
import 'package:gocar/widgets/h.dart';
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
      body: Container(),
    );
  }
}
