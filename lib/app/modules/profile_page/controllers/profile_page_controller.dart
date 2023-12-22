import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../constant/constant.dart';
import '../../profile/user_model.dart';

class ProfilePageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  late var id = ''.obs;
  late var username = ''.obs;
  late var namaLengkap = ''.obs;
  late var email = ''.obs;
  late var noTelpon = ''.obs;
  late var alamat = ''.obs;

  void setDataDiri(Pengguna user) {
    username.value = user.username!;
    namaLengkap.value = user.nama!;
    email.value = user.email!;
    noTelpon.value = user.nope!;
    alamat.value = user.alamat!;
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
