import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:trans/app/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:trans/app/modules/list_trip/pariwisata_model.dart';

class HistoryTripController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var riwayatPerjalanan = <Pariwisata>[].obs;

  initHistoryPerjalanan() async {
    riwayatPerjalanan.clear();
    try {
      String? token = await FirebaseAuth.instance.currentUser!.getIdToken();
      Uri url = Uri.parse(
          '${Constant.REALTIME_DATABASE}/pariwisata.json?auth=$token&orderBy="idDriver"&equalTo="${_auth.currentUser!.uid}"&orderBy="tersedia"&equalTo="false"');

      var response = await http.get(url);

      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map<String, dynamic>;
        data.forEach((key, value) {
          riwayatPerjalanan.add(Pariwisata.fromJson(value));
        });
        print(riwayatPerjalanan.length);
        riwayatPerjalanan.refresh();
      }
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  @override
  void onInit() {
    super.onInit();
    print('initHistoryPerjalanan');
    initHistoryPerjalanan();
  }

  @override
  void onReady() {
    print('initHistoryPerjalanan');
    super.onReady();
  }

  @override
  void onClose() {
    print('initHistoryPerjalanan');
    super.onClose();
  }
}
