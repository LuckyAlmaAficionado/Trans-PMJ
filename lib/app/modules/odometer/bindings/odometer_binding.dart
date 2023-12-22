import 'package:get/get.dart';

import '../controllers/odometer_controller.dart';

class OdometerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OdometerController>(
      () => OdometerController(),
    );
  }
}
