import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trans/app/constant/constant.dart';
import 'package:trans/app/controllers/firestore_controller.dart';
import 'package:trans/app/controllers/user_controller.dart';
import 'package:http/http.dart' as http;
import 'package:trans/app/routes/app_pages.dart';

class OdometerController extends GetxController {
  var pathFile = ''.obs;
  var urlImage = ''.obs;
  var imageUrl = ''.obs;
  XFile? pickImage;
  late TextEditingController ordometerC;

  Future<void> pickImageFrom(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;
      // Assign the file path to the variable

      pickImage = pickedImage;

      pathFile.value = pickedImage.path;
      pathFile.refresh();

      print(urlImage.value);
    } catch (e) {
      // Handle errors
      print('Error uploading image: $e');
      // You might want to show an error message to the user or handle the error in a different way
    }
  }

  mulaiTripPariwisata(String paramIdTrip, String paramOdometerAwal) {
    createNewPerjalananWisata(paramIdTrip, paramOdometerAwal);
  }

  akhiriPerjalananWisata(
    String paramIdTrip,
    String paramOdometerAkhir,
  ) async {
    print(paramIdTrip);
    print(paramOdometerAkhir);

    if (pickImage == null) {
      Constant.snackbar('Gagal', 'gambar kosong', false);
      return;
    }

    if (paramOdometerAkhir.isEmpty) {
      Constant.snackbar('Gagal', 'isi semua field', false);
      return;
    }

    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    Uri url = Uri.parse(
        '${Constant.REALTIME_DATABASE}/trip_berjalan.json?auth=$token&orderBy="idTripUtama"&equalTo="$paramIdTrip"');

    String kunci = '';
    try {
      var response = await http.get(url);

      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map<String, dynamic>;
        data.forEach((key, value) {
          print(key);
          kunci = key;
        });
        updatePerjalananAKhirWisata(kunci, paramOdometerAkhir);
      } else {
        throw ('Gagal: bro');
      }
    } catch (e) {
      throw e;
    }
  }

  updatePerjalananAKhirWisata(String key, String paramOdometerAkhir) async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    print('kunci dari: $key');
    Uri url = Uri.parse(
        '${Constant.REALTIME_DATABASE}/trip_berjalan/$key.json?auth=$token');
    var storageFirebase = Get.put(FireStorageController());
    Get.defaultDialog(
      title: 'Loading....',
      barrierDismissible: false,
      content: Center(child: CircularProgressIndicator()),
    );
    String urlImage = await storageFirebase.SendImageToStorage(pickImage!);

    try {
      var response = await http.patch(url,
          body: json.encode({
            "gambarOdometerAkhir": urlImage,
            "odometerAkhir": paramOdometerAkhir,
            "status": false,
          }));

      if (response.statusCode == 200) {
        print('berhasil: updatePerjalananAkhirWisata');
        await Get.put(UserController()).updateStatusDriver(1);
        Get.offAllNamed(Routes.HOME);
      } else {
        throw ("Error: updatePerjalananAkhirWisata");
      }
    } catch (e) {
      throw e;
    }
  }

  createNewPerjalananWisata(
    String paramIdTrip,
    String paramOdometerAwal,
  ) async {
    if (pickImage == null) {
      Constant.snackbar('Gagal', 'gambar kosong', false);
      return;
    }

    if (paramOdometerAwal.isEmpty) {
      Constant.snackbar('Gagal', 'isi semua field', false);
      return;
    }
    var storageFirebase = Get.put(FireStorageController());
    Get.defaultDialog(
      title: 'Loading....',
      titleStyle: GoogleFonts.outfit(),
      barrierDismissible: false,
      content: Center(child: CircularProgressIndicator()),
    );
    String urlImage = await storageFirebase.SendImageToStorage(pickImage!);

    if (urlImage.isEmpty) {
      return;
    }
    var token = Get.put(UserController()).tokenUserRealtimeDatabase;
    var userUid = FirebaseAuth.instance.currentUser!.uid;
    Uri url = Uri.parse(
        "${Constant.REALTIME_DATABASE}/trip_berjalan.json?auth=$token");

    var body = json.encode({
      "status": true,
      "idTripUtama": paramIdTrip,
      "idDriver": userUid,
      "idCoDriver": "",
      "gambarOdometerAwal": urlImage,
      "odometerAwal": paramOdometerAwal,
      "gambarOdometerAkhir": "",
      "odometerAkhir": "",
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });

    try {
      var response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        print("createNewPerjalananWisata BERHASIL");
        Get.find<UserController>().updateStatusDriver(3);
        Get.offAllNamed(Routes.TRIP, arguments: paramIdTrip);
      } else {
        throw ("gagal");
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  void onInit() {
    super.onInit();
    ordometerC = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    ordometerC.dispose();
    super.onClose();
  }
}
