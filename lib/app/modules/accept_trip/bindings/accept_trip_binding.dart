import 'package:get/get.dart';

import '../controllers/accept_trip_controller.dart';

class AcceptTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AcceptTripController>(
      () => AcceptTripController(),
    );
  }
}
