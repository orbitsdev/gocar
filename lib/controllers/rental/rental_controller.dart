import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gocar/api/file_api.dart';
import 'package:gocar/constants/firbase_constant.dart';
import 'package:gocar/models/vehicle.dart';
import 'package:gocar/utils/helpers/asset.dart';
import 'package:gocar/utils/modal.dart';
import 'package:uuid/uuid.dart';

import 'package:path/path.dart' as path;

class RentalController extends GetxController {
  var isCreating = false.obs;
  var isDeleting = false.obs;
  var isUpdating = false.obs;






  void updateVehicleInformation({
    required Vehicle vehicle,
    required BuildContext context,
    required String model_name,
    required String plate_number,
    required String description,
    required String price,
    required File cover_image,
    required List<File> featured_image,
    List<String>? remove_featured,
  }) async {
    try {
      isCreating(true);
      update();
      final String id = Uuid().v4();
      final String uid = auth.currentUser!.uid;

      Vehicle new_vehicle = new Vehicle(
        id: id,
        uid: uid,
        model_name: model_name,
        plate_number: plate_number,
        cover_image: '',
        featured_image: [],
        description: description,
        isSold: false,
        status: 'For Review',
        price: int.parse(price),
        created_at: DateTime.now(),
      );

      await vehicles.doc(id).set(new_vehicle.toMap());

      final String cover_image_url = await FileApi.uploadFile(
          context: context,
          folder: 'vehicles/coverimage/',
          file_id: id,
          filename: path.basename(cover_image.path),
          file: cover_image);
      final updated_cover_image = {
        'cover_image': cover_image_url,
      };

      await vehicles.doc(id).update(updated_cover_image);

      final featured_image_url =
          await Future.wait(featured_image.map((file) async {
        final file_uid = Uuid().v4();
        final featued_image_url = await FileApi.uploadFile(
          context: context,
          folder: 'vehicles/featured_image/',
          file_id: file_uid,
          filename: path.basename(file.path),
          file: file,
        );
        return featued_image_url;
      }));

      final updated_featured_image = {'featured_image': featured_image_url};
      await vehicles.doc(id).update(updated_featured_image);

      isCreating(false);
      update();

      Get.back();
      Modal.showSuccesToast(
          context: context, message: 'Succesfully Sumbmitted For Review');
    } on FirebaseException catch (e) {
      handleCreatrionError(context, e);
    } on PlatformException catch (e) {
      handleCreatrionError(context, e);
    } catch (e) {
      handleCreatrionError(context, e);
    }
  }






  void handleCreatrionError(BuildContext context, e) {
    isCreating(true);
    update();
    Modal.showErrorDialog(context: context, message: e.toString());
  }

  void submitForRequest({
    required BuildContext context,
    required String model_name,
    required String plate_number,
    required String description,
    required String price,
    required File cover_image,
    required List<File> featured_image,
  }) async {
    try {
      isCreating(true);
      update();
      final String id = Uuid().v4();
      final String uid = auth.currentUser!.uid;

      Vehicle new_vehicle = new Vehicle(
        id: id,
        uid: uid,
        model_name: model_name,
        plate_number: plate_number,
        cover_image: '',
        featured_image: [],
        description: description,
        isSold: false,
        status: 'For Review',
        price: int.parse(price),
        created_at: DateTime.now(),
      );

      await vehicles.doc(id).set(new_vehicle.toMap());

      final String cover_image_url = await FileApi.uploadFile(
          context: context,
          folder: 'vehicles/coverimage/',
          file_id: id,
          filename: path.basename(cover_image.path),
          file: cover_image);
      final updated_cover_image = {
        'cover_image': cover_image_url,
      };

      await vehicles.doc(id).update(updated_cover_image);

      final featured_image_url =
          await Future.wait(featured_image.map((file) async {
        final file_uid = Uuid().v4();
        final featued_image_url = await FileApi.uploadFile(
          context: context,
          folder: 'vehicles/featured_image/',
          file_id: file_uid,
          filename: path.basename(file.path),
          file: file,
        );
        return featued_image_url;
      }));

      final updated_featured_image = {'featured_image': featured_image_url};
      await vehicles.doc(id).update(updated_featured_image);

      isCreating(false);
      update();

      Get.back();
      Modal.showSuccesToast(
          context: context, message: 'Succesfully Sumbmitted For Review');
    } on FirebaseException catch (e) {
      handleCreatrionError(context, e);
    } on PlatformException catch (e) {
      handleCreatrionError(context, e);
    } catch (e) {
      handleCreatrionError(context, e);
    }
  }
}
