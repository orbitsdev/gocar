


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gocar/api/file_api.dart';
import 'package:gocar/constants/firbase_constant.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';
import 'package:gocar/utils/modal.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

import 'package:firebase_storage/firebase_storage.dart';


class ProfileController  extends GetxController{
  
 final authcontroller = Get.find<AuthController>();


var isUpdating = false.obs;
var isUploading = false.obs;

void handleUpdateProfileError(BuildContext context,  e){
   isUploading(false);
    update();
    Modal.showErrorDialog(context: context, message: e.toString());
}
void handleUpdateUserDetailsError(BuildContext context,  e){
  isUpdating(false);
  update();
    Modal.showErrorDialog(context: context, message: e.toString());
}

  




void updateProfile({required BuildContext context, required File new_photo}) async {
  try {
    isUploading(true);
    update();

    String uid = auth.currentUser!.uid;
    final String id = Uuid().v4();

    // Upload the new profile photo
    String downloadedUrl = await FileApi.uploadFile(
      context: context,
      folder: 'profiles/',
      file_id: uid,
      filename: path.basename(new_photo.path),
      file: new_photo,
    );

    // Delete the old profile photo if it exists and is available in Firebase Storage
    if (authcontroller.user.value.profile_image != null) {
      String oldPhotoUrl = authcontroller.user.value.profile_image!;
      String oldPhotoFilename = path.basename(oldPhotoUrl);

      // Create a reference to the old photo in Firebase Storage
      Reference oldPhotoRef = storage.ref('profiles/$uid/$oldPhotoFilename');

      // Check if the file exists
      try {
        await oldPhotoRef.getDownloadURL();
        
        // File exists, proceed with deletion
        await oldPhotoRef.delete();
        print('File deleted successfully.');
      } catch (e) {
        if (e is FirebaseException && e.code == 'object-not-found') {
          // File doesn't exist
          print('File does not exist.');
        } else {
          handleUpdateProfileError(context, e);
        }
      }
    }

    // Update the user's profile details in Firestore
    await FirebaseFirestore.instance.collection('users').doc(uid).update({'profile_image': downloadedUrl});

    await authcontroller.updateUser();

    isUploading(false);
    update();

    // Success! Do something with the updated profile details if needed
    print('Profile image updated successfully');
  } on FirebaseException catch (e) {
    handleUpdateProfileError(context, e);
  } on PlatformException catch (e) {
    handleUpdateProfileError(context, e);
  } on SocketException catch (e) {
    handleUpdateProfileError(context, e);
  } catch (e) {
    handleUpdateProfileError(context, e);
  }
}



void updateUserDetails({required BuildContext context, required String firstName, required String lastName, required String contact_number,  } ) async{
  try {
 isUpdating(true);
  update();
    
    String uid = auth.currentUser!.uid;

    // Update the user's first name and last name in Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({
      'first_name': firstName,
      'last_name': lastName,
      'contact_number': contact_number,
      
    });

    // Update the user details locally
    authcontroller.updateUser();
     isUpdating(false);
     update();
    
    Get.back();
    // Success! Do something with the updated user details if needed
    print('User details updated successfully');
  }  on FirebaseException catch (e) {
      handleUpdateUserDetailsError(context, e);
    } on PlatformException catch (e) {
      handleUpdateUserDetailsError(context, e);
    } on SocketException catch (e) {
      handleUpdateUserDetailsError(context, e);
    }catch (e){
      handleUpdateUserDetailsError(context, e);
    }
}


}