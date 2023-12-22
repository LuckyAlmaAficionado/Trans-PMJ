import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FireStorageController extends GetxController {
  SendImageToStorage(XFile image) async {
    try {
      // set file name
      String fileName = image.path.split('/').last;

      // set reference storage
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('images/$fileName');

      // send image to firebase storage
      await firebaseStorageRef.putFile(File(image.path));

      // get url download
      var urlDownload = await firebaseStorageRef.getDownloadURL();
      print("link url download: $urlDownload");
      return urlDownload;
    } catch (e) {
      throw e;
    }
  }
}
