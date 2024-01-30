import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:trans/app/controllers/firebase_storage_controller.dart';
import 'package:trans/app/controllers/image_picker_c_controller.dart';
import 'package:trans/app/modules/home/controllers/home_controller.dart';

import '../../../constant/constant.dart';
import '../../profile/user_model.dart';

class ProfilePageController extends GetxController {
  late var id = ''.obs;
  late var username = ''.obs;
  late var namaLengkap = ''.obs;
  late var email = ''.obs;
  late var noTelpon = ''.obs;
  late var alamat = ''.obs;

  RxString imgUrl = ''.obs;
  XFile? pickImage;
  RxString pathImg = ''.obs;

  void setDataDiri(Pengguna user) {
    imgUrl.value = user.profilePicture!;
    username.value = user.username!;
    namaLengkap.value = user.nama!;
    email.value = user.email!;
    noTelpon.value = user.nope!;
    alamat.value = user.alamat!;
  }

  checkIfProfilePictureIsNotNull() async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    var uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      Uri url = Uri.parse(
          '${Constant.REALTIME_DATABASE}/users.json?auth=$token&orderBy="id"&equalTo="$uid"');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map<String, dynamic>;
        if (data.values.first['profilePicture'] != null) {
          print('ada gambarnya');
          print(pathImg.value);
          final desertRef =
              FirebaseStorage.instance.ref().child('profile/${pathImg.value}');
          await desertRef.delete();
          return true;
        } else {
          print('tidak ada gambarnya');
          return false;
        }
      }
    } on FirebaseException catch (e) {
      throw ('error $e');
    }
  }

  setProfilePicture() async {
    if (await checkIfProfilePictureIsNotNull())
      pickImage =
          await ImagePickerCController.pickImageFrom(ImageSource.gallery);
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    var imageUrl =
        await FirebaseStorageController().sendImageToStorage(pickImage!);

    if (imageUrl['error']) {
      Get.snackbar('Oh Snap!', 'Gagal mengupload gambar!');
      return;
    }
    imgUrl.value = imageUrl['data'];
    try {
      Uri url =
          Uri.parse('${Constant.REALTIME_DATABASE}/users/$id.json?auth=$token');
      var response = await http.patch(
        url,
        body: json.encode({
          "profilePicture": imgUrl.value,
          "profilePicturePath": pickImage!.path.split('/').last,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success..!', 'Berhasil mengubah foto profile');
      }
      getDataDiri();
      Get.put(HomeController()).getUserProfile();
    } on FirebaseException catch (e) {
      Get.snackbar('Oh Snap!', 'Something error..! $e');
    }
  }

  Future<void> getDataDiri() async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    var uid = FirebaseAuth.instance.currentUser!.uid;
    late Pengguna user;
    Uri url = Uri.parse(
        '${Constant.REALTIME_DATABASE}/users.json?auth=$token&orderBy="id"&equalTo="$uid"');
    try {
      var response = await http.get(url);

      if (response.statusCode >= 300 && response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        var data = json.decode(response.body) as Map<String, dynamic>;
        pathImg.value = data.values.first['profilePicturePath'] ?? '';
        data.forEach((key, value) {
          id.value = key;
          user = Pengguna.fromJson(value);
        });
      }
      setDataDiri(user);
    } catch (e) {
      throw e;
    }
  }
}
