import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trans/app/constant/constant.dart';
import 'package:trans/app/routes/app_pages.dart';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../../../controllers/user_controller.dart';

class HomeController extends GetxController {
  var isTrue = true.obs;
  int onBackButton = 0;
  var namaPengguna = ''.obs;

  logout() async {
    try {
      var user = FirebaseAuth.instance.currentUser!.uid;

      if (!user.isEmpty) {
        await FirebaseAuth.instance.signOut();
        Constant.snackbar('Logout', "Berhasil logout", true);
        await Future.delayed(const Duration(seconds: 2));
        Get.offAllNamed(Routes.LOGIN);
      } else {
        throw Exception('error!');
      }
    } on Exception catch (e) {
      throw e;
    }
  }

  checkStatusUser() async {
    await Get.put(UserController()).initialData();
    var pengguna = Get.put(UserController()).currentDataRealtimeDatabase;

    print(pengguna.status);

    if (pengguna.status == 1) {
      Get.toNamed(Routes.LIST_TRIP);
    } else if (pengguna.status == 2) {
      Get.put(UserController()).findPariwisataWithIdDriver();
    } else if (pengguna.status == 3) {
      Get.toNamed(Routes.TRIP);
    }
  }

  getUserProfile() async {
    print('masuk sini getUserProfile');
    String? token = await FirebaseAuth.instance.currentUser!.getIdToken();
    Uri url = Uri.parse(
        '${Constant.REALTIME_DATABASE}/users.json?auth=$token&orderBy="id"&equalTo="${FirebaseAuth.instance.currentUser!.uid}"');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      data.forEach((key, value) {
        namaPengguna.value = value['nama'];
      });
    }
    print(namaPengguna.value);
  }

  createPerjalananWisata() async {
    var uuid = Uuid();
    String? token = await FirebaseAuth.instance.currentUser!.getIdToken();
    try {
      Uri url = Uri.parse(
          "${Constant.REALTIME_DATABASE}/pariwisata.json?auth=$token");

      var body = json.encode({
        "createdAt": DateTime.now().toIso8601String(),
        "updatedAt": DateTime.now().toIso8601String(),
        "deletedAt": DateTime.now().toIso8601String(),
        "tersedia": true,
        "id": uuid.v1().toString(),
        "idTripUtama": uuid.v4().toString(),
        "idBus": Random().nextInt(100),
        "idDriver": "",
        "idCoDriver": "",
        "tripNomor": uuid.v4().toString(),
        "tanggalBerangkat":
            DateFormat('d-MM-yyyy').format(DateTime.now()).toString(),
        "waktuBerangkat": "19:00",
        "tanggalKembali": DateFormat('d-MM-yyyy')
            .format(DateTime.now().add(const Duration(days: 10)))
            .toString(),
        "waktuKembali": "20:00",
        "tujuanWisata": "Pantai Drini Jogjakarta",
        "namaBus": "Kencana Jaya Pmj",
        "platBus": "H 1923 HX",
        "nilaiKontrak": "8750000",
      });

      var response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        print(json.decode(response.body));
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    getUserProfile();
    await Get.put(UserController()).initialData();
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
