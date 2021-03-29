import 'package:get/get.dart';

import 'package:carpart/app/modules/authiocation/controllers/authiocation_controller.dart';

class AuthiocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthiocationController>(
      () => AuthiocationController(),
    );
  }
}
