import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trans/app/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:trans/app/modules/list_trip/pariwisata_model.dart';

class ListTripController extends GetxController {
  var listPariwisata = <Pariwisata>[].obs;

  Future<void> getDataPariwisata() async {
    print('masuk sini');
    String? token = await FirebaseAuth.instance.currentUser!.getIdToken();

    try {
      Uri url = Uri.parse(
          '${Constant.REALTIME_DATABASE}/pariwisata.json?auth=$token&orderBy="tersedia"&equalTo=true');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map<String, dynamic>;
        data.forEach((key, value) {
          listPariwisata.add(Pariwisata.fromJson(value));
        });
        listPariwisata.refresh();
        print(listPariwisata);
      } else {
        throw Exception("error");
      }
    } catch (e) {
      throw e;
    }
  }

  String formatRupiah(int amount) {
    final formatCurrency =
        new NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ');
    return formatCurrency.format(amount);
  }

  @override
  void onInit() {
    super.onInit();
    getDataPariwisata();
    print('on init');
  }

  @override
  void onReady() {
    super.onReady();
    print('on ready');
  }

  @override
  void onClose() {
    super.onClose();
  }
}
