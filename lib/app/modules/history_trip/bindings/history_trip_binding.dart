import 'package:get/get.dart';

import '../controllers/history_trip_controller.dart';

class HistoryTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryTripController>(
      () => HistoryTripController(),
    );
  }
}
