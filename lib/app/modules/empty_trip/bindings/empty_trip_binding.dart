import 'package:get/get.dart';

import '../controllers/empty_trip_controller.dart';

class EmptyTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmptyTripController>(
      () => EmptyTripController(),
    );
  }
}
