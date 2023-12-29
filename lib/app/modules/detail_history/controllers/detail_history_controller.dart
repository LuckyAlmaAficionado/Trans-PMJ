import 'package:get/get.dart';
import 'package:trans/app/modules/list_trip/pariwisata_model.dart';

class DetailHistoryController extends GetxController {
  Pariwisata? detailPariwisata;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print('init nih bos');
    if (Get.arguments != null) {
      detailPariwisata = Get.arguments as Pariwisata;
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

  void increment() => count.value++;
}
