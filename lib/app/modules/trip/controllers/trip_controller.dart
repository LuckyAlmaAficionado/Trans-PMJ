import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trans/app/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:trans/app/modules/list_trip/pariwisata_model.dart';
import 'package:trans/app/modules/trip/perjalanan_model.dart';

class TripController extends GetxController {
  var detailPerjalanan = <Perjalanan>[].obs;

  // Obtain shared preferences.

  getPariwisataByIdDetailPerjalanan() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('idTripUtama');
    Pariwisata detailPariwisata = Pariwisata();
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    Uri url = Uri.parse(
        '${Constant.REALTIME_DATABASE}/pariwisata.json?auth=$token&orderBy="idTripUtama"&equalTo="$action"');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map<String, dynamic>;
        data.forEach((key, value) {
          print("value : $value");
          detailPariwisata = Pariwisata.fromJson(value);
        });
        return detailPariwisata;
      }
    } catch (e) {
      throw e;
    }
  }

  initData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('idTripUtama');
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    detailPerjalanan.clear();

    Uri urlSpesifik = Uri.parse(
        '${Constant.REALTIME_DATABASE}/trip_berjalan.json?auth=$token&orderBy="idTripUtama"&equalTo="$action"');
    try {
      var response = await http.get(urlSpesifik);

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map<String, dynamic>;

        data.forEach((key, value) {
          detailPerjalanan.add(Perjalanan.fromJson(value));
        });

        detailPerjalanan.refresh();
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    initData();
    if (Get.arguments != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('idTripUtama', Get.arguments);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
