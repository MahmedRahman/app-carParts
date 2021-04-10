import 'package:get/get.dart';

import '../controllers/stoperror_controller.dart';

class StoperrorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoperrorController>(
      () => StoperrorController(),
    );
  }
}
