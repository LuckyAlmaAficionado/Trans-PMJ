import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:trans/app/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:trans/app/controllers/user_controller.dart';
import 'package:trans/app/modules/list_trip/pariwisata_model.dart';
import 'package:trans/app/routes/app_pages.dart';

class AcceptTripController extends GetxController {
  String idBus = '';
  late String id;

  void setIdBus(String paramId) {
    idBus = paramId;
    print(idBus);
  }

  setPerjalananDiterima(String paramSupirUid, String paramPerjalananId) async {
    String? token = await FirebaseAuth.instance.currentUser!.getIdToken();
    Get.put(UserController()).updateStatusDriver(1);
    Uri url = Uri.parse(
        '${Constant.REALTIME_DATABASE}/pariwisata/$id.json?auth=$token');
    try {
      var response = await http.patch(
        url,
        body: json.encode({
          "idDriver": paramSupirUid,
          "tersedia": false,
        }),
      );

      print(json.decode(response.body));

      await Get.put(UserController()).updateStatusDriver(2);
      if (response.statusCode == 200) {
        return true;
      } else {
        Constant.snackbar("Gagal", "Error", true);
        throw ("Error");
      }
    } catch (e) {
      throw e;
    }
  }

  terimaPerjalanan(String paramId) async {
    await setPerjalananDiterima(
      FirebaseAuth.instance.currentUser!.uid,
      paramId,
    );

    Constant.snackbar("Berhasil", "tunggu sebentar", true);
    Get.offNamed(Routes.ODOMETER, arguments: {
      "isTrue": false,
      "idTrip": paramId,
    });
  }

  Future<Pariwisata> getDataPariwisata(String paramId) async {
    Pariwisata pariwisata = Pariwisata();
    String? token = await FirebaseAuth.instance.currentUser!.getIdToken();
    Uri url = Uri.parse(
        '${Constant.REALTIME_DATABASE}/pariwisata.json?auth=$token&orderBy="idTripUtama"&equalTo="$paramId"');
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map<String, dynamic>;
        data.forEach((key, value) {
          id = key;
          pariwisata = Pariwisata.fromJson(value);
        });
      }

      return pariwisata;
    } catch (e) {
      throw e;
    }
  }

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
}
