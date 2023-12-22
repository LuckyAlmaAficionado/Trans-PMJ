import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:trans/app/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:trans/app/modules/list_trip/pariwisata_model.dart';
import 'package:trans/app/modules/trip/perjalanan_model.dart';

class TripController extends GetxController {
  var detailPerjalanan = <Perjalanan>[].obs;

  getPariwisataByIdDetailPerjalanan() async {
    await initData();
    Pariwisata detailPariwisata = Pariwisata();
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    Uri url = Uri.parse(
        '${Constant.REALTIME_DATABASE}/pariwisata.json?auth=$token&orderBy="idTripUtama"&equalTo="${detailPerjalanan[0].idTripUtama}"');

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
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();

    Uri urlSpesifik = Uri.parse(
        '${Constant.REALTIME_DATABASE}/trip_berjalan.json?auth=$token&orderBy="idDriver"&equalTo="${FirebaseAuth.instance.currentUser!.uid}"');
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
  void onInit() {
    super.onInit();
    initData();
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
