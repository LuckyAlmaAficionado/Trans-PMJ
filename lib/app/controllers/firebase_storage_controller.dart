import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageController extends GetxController {
  Future<Map<String, dynamic>> sendImageToStorage(XFile imageUrl) async {
    try {
      String fileName = imageUrl.path.split('/').last;

      // set ref storage
      Reference storageRef =
          FirebaseStorage.instance.ref().child('profile/$fileName');

      // send image to firebase storage ....
      await storageRef.putFile(File(imageUrl.path));

      // get url download
      var urlDownload = await storageRef.getDownloadURL();

      return {
        "error": false,
        "message": "Berhasil mengirim gambar",
        "data": urlDownload,
      };
    } catch (e) {
      throw {
        "error": true,
        "message": "Gagal mengirim gambar: $e",
      };
    }
  }
}
