import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:trans/app/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:trans/app/modules/profile/user_model.dart';

import '../routes/app_pages.dart';

class UserController extends GetxController {
  var idUserRealtimeDatabase = ''.obs;
  var tokenUserRealtimeDatabase = ''.obs;
  Pengguna currentDataRealtimeDatabase = Pengguna();

  initialData() async {
    var kunci = '';
    String? token = await FirebaseAuth.instance.currentUser!.getIdToken();
    tokenUserRealtimeDatabase.value = token!;
    Uri url = Uri.parse(
        '${Constant.REALTIME_DATABASE}/users.json?auth=${token}&orderBy="id"&equalTo="${FirebaseAuth.instance.currentUser!.uid}"');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map<String, dynamic>;
        data.forEach((key, value) {
          idUserRealtimeDatabase.value = key;
          print(key);
          currentDataRealtimeDatabase = Pengguna.fromJson(value);
          kunci = key;
        });

        return kunci;
      } else {
        throw ('Error');
      }
    } catch (e) {}
  }

  findPariwisataWithIdDriver() async {
    var idUser = FirebaseAuth.instance.currentUser!.uid;

    Uri url = Uri.parse(
        '${Constant.REALTIME_DATABASE}/pariwisata.json?auth=${tokenUserRealtimeDatabase.value}&orderBy="idDriver"&equalTo="$idUser"');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as Map<String, dynamic>;
        data.forEach((key, value) {
          Get.toNamed(Routes.ODOMETER, arguments: {
            "isTrue": false,
            "idTrip": value['idTripUtama'],
          });
        });
      } else {
        throw ("Error: findPariwisataWithIdDriver");
      }
    } catch (e) {
      throw e;
    }
  }

  updateStatusDriver(int paramStatusId) async {
    String id = await initialData();
    String token = Get.find<UserController>().tokenUserRealtimeDatabase.value;

    print(id);
    Uri url =
        Uri.parse('${Constant.REALTIME_DATABASE}/users/$id.json?auth=$token');

    var body = json.encode({
      "status": paramStatusId,
    });

    try {
      var response = await http.patch(url, body: body);

      if (response.statusCode == 200) {
        print('Berhasil: updateStatusDriver');
      } else {
        throw ("Error");
      }
    } catch (e) {
      throw e;
    }
  }
}
