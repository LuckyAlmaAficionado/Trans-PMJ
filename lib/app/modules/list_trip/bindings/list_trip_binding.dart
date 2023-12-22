import 'package:get/get.dart';

import '../controllers/list_trip_controller.dart';

class ListTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListTripController>(
      () => ListTripController(),
    );
  }
}
