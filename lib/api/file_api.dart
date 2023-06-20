import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/constants/firbase_constant.dart';
import 'package:gocar/utils/modal.dart';

class FileApi {
  
  static Future<String> uploadFile({
    required BuildContext context,
    required String folder,
    required String file_id,
    required String filename,
    required File file,
  }) async {
    try {
      Reference ref = storage.ref('$folder/$file_id/$filename');
      UploadTask uploadTask = ref.putFile(File(file.path));
      TaskSnapshot snapshot = await uploadTask;
      Modal.showUploadProgress(context: context, snapshot: snapshot);
      final String downloadedUrl = await snapshot.ref.getDownloadURL();
      Get.back();
      return downloadedUrl;
    } catch (e) {
            Get.back();
      throw e;
    }
  }

  
  static Future<void> deleteFile({required String fileUrl}) async {
    try {
      final Reference ref = FirebaseStorage.instance.refFromURL(fileUrl);
      await ref.delete();
    } catch (e) {
      print('Error deleting file: $e');
      rethrow;
    }
  }
  
}