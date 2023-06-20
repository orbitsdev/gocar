import 'package:flutter/material.dart';

import 'package:gocar/models/vehicle.dart';

class RentalVehicleDetails extends StatefulWidget {
  Vehicle? vehicle;
   RentalVehicleDetails({
    Key? key,
    this.vehicle,
  }) : super(key: key);

  @override
  _RentalVehicleDetailsState createState() => _RentalVehicleDetailsState();
}

class _RentalVehicleDetailsState extends State<RentalVehicleDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Container(),
    );
  }
}
