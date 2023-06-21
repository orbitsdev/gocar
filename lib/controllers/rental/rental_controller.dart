import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  var vehicleTemp = Vehicle().obs;

  void handleUppdateError(BuildContext context, e) {
    isUpdating(true);
    update();
    Modal.showErrorDialog(context: context, message: e.toString());
  }

  void handleDeleteTourist(BuildContext context, e) {
    isDeleting(true);
    update();
    Modal.showErrorDialog(context: context, message: e.toString());
  }

  Future<void> delete(
      {required BuildContext context, required String id}) async {
    try {
      isDeleting(true);
      update();
      final vehicleDocs = vehicles.doc(id);
      final touristSpotData = await vehicleDocs.get();
      final coverImageUrl = touristSpotData.get('cover_image');
      final featuredImageUrls =
          List<String>.from(touristSpotData.get('featured_image'));
      await Future.wait([
        FirebaseStorage.instance.refFromURL(coverImageUrl).delete(),
        ...featuredImageUrls
            .map((url) => FirebaseStorage.instance.refFromURL(url).delete()),
        vehicleDocs.delete(),
      ]);
      isDeleting(false);
      update();
      Get.back();
    } on FirebaseException catch (e) {
      handleDeleteTourist(context, e);
    } catch (e) {
      handleDeleteTourist(context, e);
    }
  }

  void updateVehicleInformation({
    required Vehicle vehicle,
    required BuildContext context,
    required String model_name,
    required String plate_number,
    required String description,
    required String price,
    required File? cover_image,
    required List<File>? featured_image,
    List<String>? remove_featured,
  }) async {
    try {
      isUpdating(true);
      update();
      final String id = vehicle.id as String;

      // Update cover image if provided
      if (cover_image != null) {
        final String cover_image_url = await FileApi.uploadFile(
            context: context,
            folder: 'vehicles/coverimage/',
            file_id: id,
            filename: path.basename(cover_image.path),
            file: cover_image);
        final updated_cover_image = {'cover_image': cover_image_url};
        vehicle = vehicle.copyWith(cover_image: cover_image_url);
        await vehicles.doc(id).update(updated_cover_image);
      }

      // Update featured images
      if (featured_image != null) {
        // Upload new images
        final new_upload_file_url =
            await Future.wait(featured_image.map((file) async {
          final file_uid = Uuid().v4();
          final featued_image_url = await FileApi.uploadFile(
            context: context,
            folder: 'touristspot/featured_image/',
            file_id: file_uid,
            filename: path.basename(file.path),
            file: file,
          );
          return featued_image_url;
        }));

        // Combine new and old images
        final old_upload_file_url =
            List<String>.from(vehicle.featured_image ?? []);
        final updated_upload_file_url =
            old_upload_file_url + new_upload_file_url;

        // Remove images if provided
        if (remove_featured != null) {
          await Future.wait([
            ...remove_featured.map((url) async {
              await FirebaseStorage.instance.refFromURL(url).delete();
            }),
          ]);
          // Remove removed images from updated list
          updated_upload_file_url
              .removeWhere((url) => remove_featured.contains(url));
        }

        final updated_featured_image = {
          'featured_image': updated_upload_file_url
        };
        vehicle = vehicle.copyWith(featured_image: updated_upload_file_url);
        await vehicles.doc(id).update(updated_featured_image);
      }

      final filanUpdate = vehicle.copyWith(model_name: model_name,price:int.parse(price),plate_number: plate_number,description: description);
      await vehicles.doc(id).update(filanUpdate.toMap());

      isUpdating(false);
      update();

      Get.back();
      Modal.showSuccesToast(context: context, message: 'Successfully updated');
    } on FirebaseException catch (e) {
      handleUppdateError(context, e);
    } on PlatformException catch (e) {
      handleUppdateError(context, e);
    } catch (e) {
      handleUppdateError(context, e);
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
        cover_image: Asset.bannerDefault,
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
          context: context, message: 'Successfully Submitted For Review');
    } on FirebaseException catch (e) {
      handleCreatrionError(context, e);
    } on PlatformException catch (e) {
      handleCreatrionError(context, e);
    } catch (e) {
      handleCreatrionError(context, e);
    }
  }

  void approveVehicles({
    required BuildContext context,
    required Vehicle vehicle,
  }) async {
    try {
      isUpdating(true);
      update();
      final String id = vehicle.id as String;

      await vehicles.doc(id).update({'status': 'Approved'});
      // Update featured images

      isUpdating(false);
      update();

      Get.back();
      Modal.showSuccesToast(context: context, message: 'successfully Approved');
    } on FirebaseException catch (e) {
      handleUppdateError(context, e);
    } on PlatformException catch (e) {
      handleUppdateError(context, e);
    } catch (e) {
      handleUppdateError(context, e);
    }
  }
}
