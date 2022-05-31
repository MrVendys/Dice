import 'package:get/get.dart';

import '../controllers/dices_controller.dart';

class DicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DicesController>(
      () => DicesController(),
    );
  }
}
