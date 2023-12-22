import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trans/app/modules/profile/user_model.dart';
import 'package:trans/app/routes/app_pages.dart';

import '../../../constant/constant.dart';

class ProfileController extends GetxController {
  var firebase = FirebaseAuth.instance.currentUser!;

  @override
  void onInit() {
    super.onInit();
    usernameC = TextEditingController();
    namaLengkapC = TextEditingController();
    emailC = TextEditingController();
    noTelponC = TextEditingController();
    alamatC = TextEditingController();
  }

  late TextEditingController usernameC;
  late TextEditingController namaLengkapC;
  late TextEditingController emailC;
  late TextEditingController noTelponC;
  late TextEditingController alamatC;

  late var id = ''.obs;
  late var username = ''.obs;
  late var namaLengkap = ''.obs;
  late var email = ''.obs;
  late var noTelpon = ''.obs;
  late var alamat = ''.obs;

  checkTextField(
    String username,
    String nama,
    String email,
    String noTelpon,
    String alamat,
  ) {
    if (username == "" ||
        nama == "" ||
        email == "" ||
        noTelpon == "" ||
        alamat == "") {
      Constant.snackbar("Gagal", "isi semua field kosong", false);
      return false;
    } else if (!email.contains("@") && !email.contains(".")) {
      Constant.snackbar("Gagal", "Format email salah", false);
      return false;
    } else {
      print('masuk true');
      return true;
    }
  }

  Future<void> updateDataDiri(
    String username,
    String nama,
    String email,
    String noTelpon,
    String alamat,
  ) async {
    if (checkTextField(
      username,
      nama,
      email,
      noTelpon,
      alamat,
    )) {
      var token = await FirebaseAuth.instance.currentUser!.getIdToken();
      print(id);
      Uri url =
          Uri.parse('${Constant.REALTIME_DATABASE}/users/$id.json?auth=$token');

      try {
        var response = await http.patch(
          url,
          body: json.encode({
            "updateAt": DateTime.now().toIso8601String(),
            "username": username,
            "nama": nama,
            "alamat": alamat,
            "nope": noTelpon,
            "email": email,
            "status": 1,
            "role": "driver",
          }),
        );

        if (response.statusCode > 300 || response.statusCode < 200) {
          throw (response.statusCode);
        } else {
          Constant.snackbar("Berhasil", "data berhasil diperbaharui", true);
          await Future.delayed(const Duration(seconds: 2));
          Get.back();
          Get.toNamed(Routes.HOME);
        }
      } catch (e) {
        throw e;
      }
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

  void setDataDiri(Pengguna user) {
    username.value = user.username!;
    namaLengkap.value = user.nama!;
    email.value = user.email!;
    noTelpon.value = user.nope!;
    alamat.value = user.alamat!;

    usernameC.text = user.username!;
    namaLengkapC.text = user.nama!;
    emailC.text = user.email!;
    noTelponC.text = user.nope!;
    alamatC.text = user.alamat!;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    usernameC.dispose();
    namaLengkapC.dispose();
    emailC.dispose();
    noTelponC.dispose();
    alamatC.dispose();
    super.onClose();
  }
}
