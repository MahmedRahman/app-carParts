import 'package:get/get.dart';

import '../controllers/tremsnew_controller.dart';

class TremsnewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TremsnewController>(
      () => TremsnewController(),
    );
  }
}
