import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trans/app/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:trans/app/controllers/firestore_controller.dart';
import 'package:trans/app/routes/app_pages.dart';

class CashflowController extends GetxController {
  var pathFile = ''.obs;
  late TextEditingController nominalC;
  late TextEditingController tujuanPengeluaranC;
  late TextEditingController locationC;
  XFile? pickImage;

  Future<void> pickImageFrom(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    pickImage = returnImage;

    pathFile.value = returnImage!.path;
    pathFile.refresh();
  }

  sendDataPengeluaranBensin(
    String idTrip,
    String tujuanPengeluaran,
    String nominal,
    String alamat,
  ) async {
    print(idTrip.isEmpty);
    print(tujuanPengeluaran.isEmpty);
    print(nominal.isEmpty);
    print(alamat.isEmpty);

    if (nominal.isEmpty && alamat.isEmpty) {
      Constant.dialog('Gagal', 'Isi semua field', false);
      return;
    } else if (pickImage == null) {
      Constant.dialog('Gagal', 'Gambar masih kosong', false);
      return;
    }

    var storage = Get.put(FireStorageController());
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    Uri url =
        Uri.parse('${Constant.REALTIME_DATABASE}/pengeluaran.json?auth=$token');
    Get.defaultDialog(
      title: 'Loading....',
      barrierDismissible: false,
      content: Center(child: CircularProgressIndicator()),
    );
    String urlImage = await storage.SendImageToStorage(pickImage!);
    Get.back();

    try {
      var response = await http.post(
        url,
        body: json.encode({
          "urlImage": urlImage,
          "tujuanPengeluaran": tujuanPengeluaran,
          "nominalPembelian": nominal,
          "alamatPembelian": alamat,
          "idTrip": idTrip,
          "idDriver": FirebaseAuth.instance.currentUser!.uid,
        }),
      );

      if (response.statusCode == 200) {
        Constant.snackbar('Berhasil', 'Laporan berhasil disimpan', true);
        await Future.delayed(const Duration(seconds: 2));
        Get.offAllNamed(Routes.TRIP);
      } else {
        Constant.snackbar("Gagal", "Ulangi proses", false);
        throw ("Error: sendDataPengeluaranBensin");
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  void onInit() {
    super.onInit();
    nominalC = TextEditingController();
    tujuanPengeluaranC = TextEditingController();
    locationC = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nominalC.dispose();
    tujuanPengeluaranC.dispose();
    locationC.dispose();
    super.onClose();
  }
}
